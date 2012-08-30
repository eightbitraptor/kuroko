require 'vagrant'
require "kuroko/errors"
require "kuroko/configuration"
require "kuroko/vagrant_support"
require "core_ext/cucumber/rb_language"

module Kuroko
  def self.configure
    yield(Configuration.instance)
  end
end
