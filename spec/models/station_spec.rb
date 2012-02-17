require 'spec_helper'

describe Station do

  before(:each) do
    @station = Factory(:station)
  end

  it "should allow me to change the coordinates of a place" do
    @station.apply_geo({"lat" => "19.4", "lon" => "-99.15"})
    @station.coordinates.lat.should == 19.4
    @station.coordinates.lon.should == -99.15
  end
end