#encoding: utf-8
require 'spec_helper'

describe Transport do

  it "should retrieve the integer mode of a symbol given mode" do
    Transport.mode_for(:subway).should == 2
    Transport.mode_for(:bike_sharing).should == 1
  end
  
  it "should transform all transport modes to a humanized version" do
    humanized_modes = Transport.humanized_modes
    simple_modes = Transport.modes
    simple_modes.keys.each do |key|
      simple_modes[key].to_s.humanize.should == humanized_modes[key]
    end
  end
  
  describe "having a bike sharing transport system registered" do
  
    before(:each) do
      @ecobici = Factory.build(:ecobici)
    end
  
    it "should confirm it's a bike sharing transport mode" do
      @ecobici.transport_mode_is?(:bike_sharing).should be_true
    end
    
  end
end