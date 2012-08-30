require 'vagrant'
require "cucumber-puppet/errors"
require "cucumber-puppet/configuration"
require "cucumber-puppet/vagrant_support"
require "core_ext/cucumber/rb_language"

module Cucumber
  module Puppet

    def self.configure
      yield(Configuration.instance)
    end
  end
end
