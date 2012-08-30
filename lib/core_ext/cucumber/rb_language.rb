module Cucumber
  module RbSupport
    class RbLanguage
      alias_method :extend_world_original, :extend_world

      def extend_world
        @current_world.extend(Cucumber::Puppet::VagrantSupport)
        extend_world_original
      end
    end
  end
end
