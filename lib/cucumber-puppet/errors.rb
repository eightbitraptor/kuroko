module Cucumber
  module Puppet
    class VagrantNotRunningException < RuntimeError; end
    class VagrantSshCommandError < RuntimeError; end
  end
end

