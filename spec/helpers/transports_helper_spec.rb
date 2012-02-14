#encoding: utf-8
require 'spec_helper'

describe TransportsHelper do

  it "for a count of 1 it should generate a singular HTML presentation" do
    count_humanized_with('messages.stations.number', 1).should == "<span class=\"number\">1 estación</span>".html_safe
  end

  it "for a count of 2 it should generate a plural HTML presentation" do
    count_humanized_with('messages.stations.number', 2).should == "<span class=\"number\">2 estaciones</span>".html_safe
  end
  
end