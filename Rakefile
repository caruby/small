require 'fileutils'
require File.expand_path('version', File.dirname(__FILE__) + '/lib/casmall')

desc "Default: run all tests"
task :default => :test

# the gem name
GEM = 'caruby-small'
GEM_VERSION = CaSmall::VERSION

WINDOWS = (Config::CONFIG['host_os'] =~ /mingw|win32|cygwin/ ? true : false) rescue false
SUDO = WINDOWS ? '' : 'sudo'

desc 'Builds the gem'
task :gem do
  sh "jgem build #{GEM}.gemspec"
end

desc 'Installs the gem'
task :install => :gem do
  sh "#{SUDO} jgem install #{GEM}-#{GEM_VERSION}.gem"
end

desc 'Documents the API'
task :doc do
  FileUtils.rm_rf 'doc/api'
  sh "yardoc"
end

desc 'Runs the specs'
task :spec do
  Dir['spec/**/*_spec.rb'].each { |f| sh "rspec #{f}" rescue nil }
end

desc 'Runs the tests'
task :test => :spec
