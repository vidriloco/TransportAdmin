require 'spec_helper'

describe Segment do
  
  before(:each) do
    @line = Factory(:red_line, :transport_id => Factory(:metro).id)
    @observatorio = Factory(:observatorio, :line => @line)
    @tacubaya = Factory(:tacubaya, :line => @line)
  end
  
  describe "should NOT let save a new record" do
    it "pointing to the same stations in the same ordering with no double direction set, when a identical one exists" do
      params_of_one_use_only={:origin_station_id => @observatorio.id, :destination_station_id => @tacubaya.id, :line_id => @line.id}
      Segment.create params_of_one_use_only
      Segment.new(params_of_one_use_only).save.should be_false
    end
  
    it "pointing to the same stations in different ordering with no double direction set, when a identical one exists" do
      Segment.create({:origin_station_id => @observatorio.id, :destination_station_id => @tacubaya.id, :line_id => @line.id})
      Segment.new({:origin_station_id => @tacubaya.id, :destination_station_id => @observatorio.id}).save.should be_false
    end
  end
  
  describe "should let update an existing record" do
    
    before(:each) do
      @segment = Segment.create({:origin_station_id => @observatorio.id, :destination_station_id => @tacubaya.id, :double_direction => false, :line_id => @line.id})
    end
    
    it "with a different ordering of stations" do
      @segment.update_attributes({:origin_station_id => @tacubaya.id, :destination_station_id => @observatorio.id}).should be_true
    end
    
    it "with the same ordering of stations" do
      @segment.update_attributes({:origin_station_id => @observatorio.id, :destination_station_id => @tacubaya.id}).should be_true
    end
    
    it "with no changes made" do
      @segment.update_attributes({}).should be_true
    end
    
  end
end
