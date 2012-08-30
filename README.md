# Cucumber::Puppet

A cucumber plugin to allow integraion testing of Puppet manifests using Vagrant.

## Installation

Add this line to your application's Gemfile:

    gem 'cucumber-puppet'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cucumber-puppet

## Usage

Require the library in your `features/support/env.rb`

    require 'cucumber-puppet'

Configure the library to point to a vagrant environment (ie. a directory containing a Vagrantfile) to test your puppet repositories against

    Cucumber::Puppet.configure do |config|
      config.vagrant_root = File.expand_path(File.join(__FILE__, 'vagrant_root'))

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
