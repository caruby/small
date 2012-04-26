require 'sinatra'
require 'casmall/web_service'

# Make the request handler.
ws = CaSmall::WebService.new

# match on class/id or class?attribute=value[&attribute=value ...]
get %r{/(\w+)(?:/(\d+))?} do |name, id|
  # The value hash is either the id argument or the URL parameters.
  vh = id ? {'identifier' => id} : params.delete_if { |k, v| k == 'captures' }
  # delegate to the web service
  ws.find(name, vh)
end

post %r{/query(?:/([\w/]+))?} do |path|
  ws.query(params[:json], path)
end

post '/' do
  ws.create(params[:json])
end

put '/' do
  ws.update(params[:json])
end
