require 'singleton'

module Kuroko
  class Configuration
    include Singleton

    attr_accessor :vagrant_root
  end
end

