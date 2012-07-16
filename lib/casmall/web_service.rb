require 'json'

module CaSmall
  # The WebService processes catissuews requests.
  class WebService
    # @param [Module] mod the application domain module, e.g. +CaTissue+.
    def initialize(mod)
      @context = mod
    end
    
    # @param [String] name the search target class name, singular or plural
    # @param [{String=>String}] params the attribute => value search arguments
    # @return [String, nil] the JSON content of the matching object(s), or nil if no match
    def find(name, params)
      # the caTissue class to find
      tgt = name.singularize
      logger.info { "caSmall finding #{name.qp} #{params.qp}..." }
      klass = @context.const_get(tgt.camelize)
      # the attribute => value hash
      vh = {}
      # Convert the parameters into attribute => value entries.
      params.each do |k, v|
        pa = k.to_sym
        # the standard property
        prop = klass.property(pa)
        # Convert a numeric attribute string argument to an integer. 
        v = v.to_i if prop.type < Java::JavaLang::Number
        vh[pa] = v
      end
      # the search template
      tmpl = klass.new(vh)
      # the search result
      result = tgt == name ? tmpl.find : tmpl.query      
      # convert the search result, if any, to JSON 
      if result then
        logger.info { "caSmall found #{result.qp}." }
        result.to_json
      end
    end
    
    # @param [String] json the JSON representation of the query template
    # @param [String, nil] path the optional query attribute path
    # @return [String, nil] the JSON content of the matching objects, or nil if no match
    def query(json, path=nil)
      path_a = path ? path.split('/').map { |s| s.to_sym } : Array::EMPTY_ARRAY
      # Bump the default nesting, since a query result can be deeply nested. 
      JSON[json].query(*path_a).to_json(:max_nesting => 100)
    end
    
    # @param [String] json the JSON representation of the object to create
    # @return [String] the created object's identifier as a JSON string 
    def create(json)
      JSON[json].create.identifier.to_json
    end
    
    # @param [String] json the JSON representation of the object to update
    def update(json)
      obj = JSON[json]
      if obj.identifier.nil? then
        obj.find or raise NotFoundError.new("Object to update was not found in the database: #{obj}")
      end
      obj.update
      true.to_json
    end
  end
end