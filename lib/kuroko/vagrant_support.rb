module Kuroko
  module VagrantSupport

    at_exit {
      if ENV['KEEP_RUNNING'] != "true"
        new_env = Object.new.extend(self).send(:vagrant_env)
        new_env.cli('destroy', '-f')
      end
    }

    def vagrant_cli_command(command)
      vagrant_env.cli(command)
    end

    def vagrant_sandbox_command(command, path=vagrant_root)
      invoke_sandbox_command(command, path)
    end

    def run_vagrant_command(command, options={})
      run_command(:execute, command, options)
    end

    def run_sudo_command(command, options={})
      run_command(:sudo, command, options)
    end

    private

    def vagrant_env
      @vagrant ||= Vagrant::Environment.new(:cwd => vagrant_root)
    end

    def run_command(method, command, options)
      if vagrant_env.primary_vm.state != :running
        raise VagrantNotRunningException
      end

      code = vagrant_env.primary_vm.channel.send(method, command) do |type, data|
        if !(options[:silent]) && ([:stdout, :stdout].include? type)
          puts data
        end
      end

      if !options[:no_verify] && code != 0
        raise VagrantSshCommandError
      end
      code
    end

    def invoke_sandbox_command(command, path)
      pwd = Dir.pwd
      begin
        Dir.chdir(path)
        vagrant_env.cli('sandbox', command)
      ensure
        Dir.chdir(pwd)
      end
    end

    def vagrant_root
      @vagrant_root ||= Configuration.instance.vagrant_root
    end
  end
end
