require 'rubygems'
require 'bundler/setup'
Bundler.require(:test, :development)
 
require 'casmall'

module CaSmall::Test
  RESULTS = File.dirname(__FILE__) + '/../test/results'
end

# Open the logger.
Jinx::Log.instance.open(CaSmall::Test::RESULTS + '/log/casmall.log', :debug => true)

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }
