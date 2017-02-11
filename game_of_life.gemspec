# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'game_of_life/version'

Gem::Specification.new do |spec|
  spec.name          = 'game_of_life'
  spec.version       = GameOfLife::VERSION
  spec.authors       = ['Rob Cole']
  spec.email         = ['robcole@gmail.com']
  spec.summary       = 'Game of Life as a Ruby Gem'
  spec.description   = 'TDD Practice: Game of Life Ruby Gem'
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-bundler'
  spec.add_development_dependency 'guard-rspec'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rb-readline'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
end
