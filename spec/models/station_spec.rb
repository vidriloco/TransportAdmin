#encoding: utf-8
require 'spec_helper'

# For any stations A - B
# A --c--> B where 'c' is considered an incoming relation respect B. A is a previous station
# A <--c-- B where 'c' is considered an outcoming relation respect B. A is a next station
describe Station do

  before(:each) do
    @line = Factory(:brown_line, :transport_id => Factory(:metro).id)
  end

  describe "having registered a station" do

    before(:each) do
      @station = Factory(:observatorio, :line => @line)
    end

    it "should allow me to change the coordinates of it" do
      @station.apply_geo({"lat" => "19.4", "lon" => "-99.15"})
      @station.coordinates.lat.should == 19.4
      @station.coordinates.lon.should == -99.15
    end
    
  end
  
end