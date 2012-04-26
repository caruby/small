require 'spec/spec_helper'

module CaSmall
  describe 'Create' do
    include RackTest
    
    before(:all) do
      @reg = seed.registration
    end
    
    subject { @reg }
    
  	it 'should create a new registration' do
      post '/', :json => subject.to_json
      last_response.should be_ok
      id_s = last_response.body
      id_s.should match /^\d+$/
      fetched = subject.class.new(:identifier => id_s.to_i).find
      fetched.should_not be nil
      scgs = fetched.specimen_collection_groups
      scgs.size.should be 1
      scgs.first.specimens.size.should be 1
    end
    
  	it 'should create an annotation' do
  	  pnt = @reg.participant
      lab = CaTissue::Participant::Clinical::LabAnnotation.new
      lab.merge_attributes(:lab_test_name => 'Test Lab', :participant => pnt)
      post '/', :json => lab.to_json
      last_response.should be_ok
    end
  end
end
