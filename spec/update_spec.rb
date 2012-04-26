require 'spec/spec_helper'

module CaSmall
  describe 'Update' do
    include RackTest
    
    before(:all) do
      @spc = seed.specimen.create
    end
    
    subject { @spc }
    
  	it 'should update a specimen quantity' do
  	  qty = subject.available_quantity /= 2
      put '/', :json => subject.to_json
      last_response.should be_ok
      fetched = subject.copy(:identifier).find
      fetched.available_quantity.should be_within(0.00001).of(qty)
    end
    
  	it 'should add a specimen annotation' do
      pst = CaTissue::Specimen::Pathology::ProstateSpecimenPathologyAnnotation.new
      pst.merge_attributes(:specimen => subject)
      grd = CaTissue::Specimen::Pathology::SpecimenHistologicGrade.new
      grd.merge_attributes(:grade => 3, :specimen_base_solid_tissue_pathology_annotation => pst)
      put '/', :json => subject.to_json
      last_response.should be_ok
      # TODO - Uncomment when annotation query supported
      # fetched = subject.copy(:identifier).find
      # fpst = fetched.pathology.prostate_specimen_pathology_annotations.first
      # fpst.should_not be nil
      # fgrd = fpst.histologic_grades.first
      # fgrd.should_not be nil
      # fgrd.grade.should be grd.grade
    end
  end
end
