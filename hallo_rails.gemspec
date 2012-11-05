# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hallo_rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nico"]
  gem.email         = ["nico.ritsche@gmail.com"]
  gem.description   = %q{ Use the Hallo editor to edit content in a Rails app. }
  gem.summary       = %q{ Use the Hallo editor to edit content in a Rails app. }
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hallo_rails"
  gem.require_paths = ["lib"]
  gem.version       = HalloRails::VERSION

  gem.add_dependency 'rails', '>= 3.1.0'
end
