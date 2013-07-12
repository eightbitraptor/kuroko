require 'spec_helper'
require 'kuroko'

describe "VagrantSupport Module" do
  subject{ Object.new.extend(Kuroko::VagrantSupport) }
  let(:mock_env){ double('Environment', cli: nil) }

  before do
    subject.stub(:vagrant_env).and_return(mock_env)
  end

  describe "#vagrant_cli_command" do
    it "passes the cli command on to the vagrant environment" do
      mock_env.should_receive(:cli).with('foobar')

      subject.vagrant_cli_command('foobar')
    end
  end

  describe "#run_vagrant_sandbox_command" do
    before do
      Dir.stub(:chdir)
    end

    it "changes into the specified working directory" do
      Dir.should_receive(:chdir).with('/tmp/path')

      subject.vagrant_sandbox_command('dontcare', '/tmp/path')
    end

    it "runs the specified command against the vagrant env" do
      mock_env.should_receive(:cli).with('sandbox', 'dontcare')

      subject.vagrant_sandbox_command('dontcare', '/tmp/path')
    end

    it "changes back into the old working directory" do
      Dir.should_receive(:chdir).with(Dir.pwd)

      subject.vagrant_sandbox_command('dontcare', '/tmp/path')
    end

    it 'changes back to the old working dir even on a failure' do
      Dir.should_receive(:chdir).with(Dir.pwd)
      mock_env.stub(:cli){ raise "Boom!" }

      expect{
        subject.vagrant_sandbox_command('dontcare', '/tmp/path')
      }.to raise_error
    end
  end

  describe "#run_vagrant_command" do
    before do
      mock_env.stub_chain(:primary_vm, :state){ :running }
    end

    it "raises an error if the VM has crashed" do
      mock_env.stub_chain(:primary_vm, :state){ :fucked }

      expect{
        subject.run_vagrant_command('hostname')
      }.to raise_error(Kuroko::VagrantNotRunningException)
    end

    it "sets the vagrant command to execute" do
      subject.should_receive(:run_command).with(:execute, 'hostname', {})
      subject.run_vagrant_command('hostname')
    end

    it "passes through the options hash" do
      subject.should_receive(:run_command).with(:execute,
                                                'hostname',
                                                {no_verify: true})
      subject.run_vagrant_command('hostname', no_verify: true)
    end

    it "raises and exception if the ssh exit code is nonzero" do
      mock_env.stub_chain(:primary_vm, :channel, :send){ 1 }

      expect{
        subject.run_vagrant_command('hostname')
      }.to raise_error(Kuroko::VagrantSshCommandError)
    end

    it "doesn't check the exit status with no_verify" do
      mock_env.stub_chain(:primary_vm, :channel, :send){ 1 }

      expect{
        subject.run_vagrant_command('hostname', no_verify: true)
      }.to_not raise_error
    end

    describe "running commands with sudo" do
      it "sets the vagrant command to sudo" do
        subject.should_receive(:run_command).with(:sudo, 'hostname', {})
        subject.run_sudo_command('hostname')
      end
    end
  end
end
