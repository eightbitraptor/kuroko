require 'rspec'

# Stub out the Vagrant Environment so that we don't try and load VM's when
# running the tests

module Vagrant
  class Environment
    def initialize(args)
      #NOOP
    end

    def cli(command, options=nil)
      # NOOP
    end
  end
end

module Cucumber
  module RbSupport
    class RbLanguage
      attr_reader :current_world

      def extend_world
        # NOOP
      end
    end
  end
end
