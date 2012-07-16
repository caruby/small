require 'rubygems'
require 'bundler'
Bundler.require

require 'casmall'
require 'jinx/helpers/log'

# the logger
use Rack::CommonLogger, Jinx.logger(:app => 'CaSmall', :debug => true)

# start the application
run CaSmall::App.new(CaTissue)
