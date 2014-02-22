# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opsicle/version'

Gem::Specification.new do |spec|
  spec.name          = "opsicle"
  spec.version       = Opsicle::VERSION
  spec.authors       = ["Andy Fleener"]
  spec.email         = ["andrew.fleener@sportngin.com"]
  spec.description   = %q{CLI for the opsworks platform}
  spec.summary       = %q{An opsworks specific abstraction on top of the aws sdk}
  spec.homepage      = "https://github.com/sportngin/opsicle"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.extensions    = 'ext/mkrf_conf.rb'

  spec.add_dependency "aws-sdk", "~> 1.30"
  spec.add_dependency "commander"
  spec.add_dependency "terminal-table"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "3.0.0.beta1" # Pinning to beta1 until https://github.com/guard/guard-rspec/pull/250 is closed
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-rspec"

  if RUBY_VERSION >= '2.1'
    # This is only for development; note that RUBY_VERSION is evaluated at
    # build-time, not install-time. ext/mkrf_conf.rb takes care of the install-
    # time dependency; this takes care of the development-time dependency.
    # Note that this doesn't work in Gemfile, since :ruby_21 is not a valid
    # platform in Ruby 1.9.3.
    # See ext/mkrf_conf.rb for more information
    spec.add_development_dependency "curses", "~> 1.0"
  end
end
