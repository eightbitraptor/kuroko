# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors       = ["Matt House"]
  gem.email         = ["matt@eightbitraptor.com"]
  gem.description   = %q{Cucumber Plugin for testing Puppet manifests using Vagrant}
  gem.summary       = %q{Cucumber Plugin for testing Puppet manifests using Vagrant}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "kuroko"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.1"

  gem.add_dependency('vagrant')
  gem.add_dependency('cucumber')

  gem.add_development_dependency('rspec')
  gem.add_development_dependency('rake')
end
