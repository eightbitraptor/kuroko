require 'singleton'

module Cucumber
  module Puppet
    class Configuration
      include Singleton

      attr_accessor :vagrant_root
    end
  end
end

