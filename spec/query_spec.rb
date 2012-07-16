require 'spec/spec_helper'

module CaSmall
  describe 'Query' do
    include RackTest

  	it 'should query an existing Site' do
      site = CaTissue::Site.default_site
      post "/query", :json => site.to_json
      last_response.should be_ok
      fetched = JSON[last_response.body]
      fetched.size.should be 1
      site.content_matches?(fetched.first).should be true
    end

  	it 'should query a Site -> coordinator path' do
      site = CaTissue::Site.default_site
      post '/query/coordinator', :json => site.to_json
      last_response.should be_ok
      fetched = JSON[last_response.body]
      fetched.size.should be 1
    end

  	it 'should query registration specimens' do
  	  reg = seed.registration.create
  	  pnt = reg.participant
  	  spc = pnt.specimens.first
  	  tmpl = reg.copy(:identifier)
      post '/query/specimen_collection_groups/specimens', :json => tmpl.to_json
      last_response.should be_ok
      fetched = JSON[last_response.body]
      fetched.size.should be 1
      fetched.first.content_matches?(spc).should be true
    end
  end
end
