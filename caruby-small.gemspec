require 'rubygems'
require 'bundler'

require 'date'
require File.expand_path('version', File.dirname(__FILE__) + '/lib/casmall')

Gem::Specification.new do |s|
  s.name          = 'caruby-small'
  s.summary       = 'caSmall web service'
  s.description   = s.summary + '. See the Git README for more information.'
  s.version       = CaSmall::VERSION
  s.date          = Date.today
  s.author        = "OHSU"
  s.email         = "loneyf@ohsu.edu"
  s.require_path  = 'lib'
  s.bindir        = 'bin'
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files spec`.split("\n")
  s.executables   = `git ls-files bin`.split("\n").map { |f| File.basename(f) }
  s.add_runtime_dependency     'bundler'
  s.add_runtime_dependency     'rack'
  s.add_runtime_dependency     'sinatra'
  s.add_runtime_dependency     'sinatra-authorization'
  s.add_runtime_dependency     'jruby-openssl'
  s.add_runtime_dependency     'caruby-tissue', '>= 2.1.4'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'rake'
  s.has_rdoc      = 'yard'
  s.license       = 'MIT'
end
