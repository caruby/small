require 'sinatra'
require 'catissue'
require 'casmall/authorization'
require 'casmall/web_service'

module CaSmall
   class App < Sinatra::Base
     include Authorization

     set :root, File.dirname(__FILE__) + '/..'

     if development? then
       # Don't generate fancy HTML for stack traces.
       disable :show_exceptions
       # Allow errors to get out of the app so Cucumber can display them.
       enable :raise_errors
     end

     # The authorization page name.
     set :authorization_realm, 'Please enter your username and caTissue password'

     enable :sessions
     
     def initialize(mod, *args)
       super(*args)
       #the request handler.
       @ws = CaSmall::WebService.new(mod)
     end    

    # Match on the class/id or class?attribute=value[&attribute=value ...].
    get %r{/(\w+)(?:/(\d+))?} do |name, id|
      # The value hash is either the id argument or the URL parameters.
      vh = id ? {'identifier' => id} : params.delete_if { |k, v| k == 'captures' }
      # delegate to the web service
      @ws.find(name, vh)
    end

    # Match on +query+ with request parameters.
    post %r{/query(?:/([\w/]+))?} do |path|
      @ws.query(params[:json], path)
    end

    post '/' do
      @ws.create(params[:json])
    end

    put '/' do
      @ws.update(params[:json])
    end
  end
end

