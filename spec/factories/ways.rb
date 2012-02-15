# encoding: utf-8

FactoryGirl.define do
  
  factory(:way) do |t|
    t.content LineString.from_coordinates([[1.5,45.2],[-54.12312,-0.012]],4326,false,false)
    t.description "A simple way of a line"
  end
  
end