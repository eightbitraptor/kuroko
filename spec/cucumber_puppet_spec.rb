require 'spec_helper'
require 'cucumber-puppet'

describe "configuring Cucumber Puppet" do
  it "has a configuration api" do
    Cucumber::Puppet.should respond_to(:configure)
  end

  it 'yields the configuration instance to the block' do
    Cucumber::Puppet.configure do |c|
      c.should == Cucumber::Puppet::Configuration.instance
    end
  end

  describe Cucumber::Puppet::Configuration do
    subject{ Cucumber::Puppet::Configuration.instance }

    it "is a singleton" do
      subject.should == Cucumber::Puppet::Configuration.instance
    end

    it 'stores the vagrant_root path' do
      subject.vagrant_root = 'foobar'
      subject.vagrant_root.should == 'foobar'
    end
  end

end
