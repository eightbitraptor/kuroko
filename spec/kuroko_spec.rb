require 'spec_helper'
require 'kuroko'

describe "configuring Cucumber Puppet" do
  it "has a configuration api" do
    Kuroko.should respond_to(:configure)
  end

  it 'yields the configuration instance to the block' do
    Kuroko.configure do |c|
      c.should == Kuroko::Configuration.instance
    end
  end

  describe Kuroko::Configuration do
    subject{ Kuroko::Configuration.instance }

    it "is a singleton" do
      subject.should == Kuroko::Configuration.instance
    end

    it 'stores the vagrant_root path' do
      subject.vagrant_root = 'foobar'
      subject.vagrant_root.should == 'foobar'
    end
  end

end
