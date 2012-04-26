require 'rack/test'
require Bundler.environment.specs.detect { |s| s.name == 'caruby-tissue' }.full_gem_path + '/test/helpers/seed'

def app
  Sinatra::Application
end

module CaSmall
  module RackTest
    include Rack::Test::Methods
    
    def seed
      CaTissue::TestCase::Seed.new.uniquify
    end
  end
end
