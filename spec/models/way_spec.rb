require 'spec_helper'

describe Way do

  before(:each) do
    @line = Factory(:red_line, :transport_id => Factory(:metro).id)
  end

  it "should generate a humanized description for a way" do
    way=Factory(:way, :line_id => @line.id)
    way.humanized_content.should == I18n.t('ways.show.human_description.other', :number => 2)
  end
  
  it "should initialize a new Way element" do
    
    way=Way.new_with_filtering(
        :description => "A simple way of a line", 
        :line_id => @line.id,
        :content => "1.5,45.2,0 -54.12312,-0.012,0")
    way.description.should == "A simple way of a line"
    way.content.should == LineString.from_coordinates([[1.5,45.2],[-54.12312,-0.012]],4326,false,false)
    way.line.should == @line
  end

end
