require 'spec_helper'
require 'cucumber-puppet'

describe "Monkeypatching Cucumber" do
  subject{ Cucumber::RbSupport::RbLanguage.new }

  it "extends the world with the VagrantSupport module" do
    subject.extend_world

    subject.current_world.class.ancestors.should include(Cucumber::Puppet::VagrantSupport)
  end
end
