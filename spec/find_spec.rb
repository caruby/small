require 'uri'
require 'spec/spec_helper'
require 'jinx/helpers/uniquifier'

module CaSmall
  describe 'Find' do
    include RackTest

  	it "should find an existing Participant" do
      pnt = CaTissue::Participant.new(:last_name => Jinx::Uniquifier.qualifier.to_s).create
      get "/participant/#{pnt.id}"
      last_response.should be_ok
      fetched = JSON[last_response.body]
      fetched.identifier.should_not be_nil
      pnt.content_matches?(fetched).should be true
    end

  	it "should find an existing Site by name" do
      site = CaTissue::Site.default_site
      get "/site?name=#{URI.escape(site.name)}"
      last_response.should be_ok
      fetched = JSON[last_response.body]
      fetched.identifier.should_not be_nil
      site.content_matches?(fetched).should be true
    end
  end
end
