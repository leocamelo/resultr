# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resultr/version'

Gem::Specification.new do |spec|
  spec.name          = 'resultr'
  spec.version       = Resultr::VERSION
  spec.authors       = ['@leocamelo']
  spec.email         = ['leonardocamelo.nave@gmail.com']
  spec.summary       = 'Ruby beatiful results'
  spec.description   = 'Resultr provides a simple interface to function results'
  spec.homepage      = 'https://github.com/leocamelo/resultr'
  spec.license       = 'MIT'
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.3'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test)/})
  end

  spec.add_development_dependency 'bundler',  '~> 2.2'
  spec.add_development_dependency 'minitest', '~> 5.14'
  spec.add_development_dependency 'rake',     '~> 13.0'
  spec.add_development_dependency 'rubocop',  '~> 1.8'
end
