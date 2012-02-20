# encoding: utf-8

FactoryGirl.define do
  
  factory :docking_station, :class => DockingStation do |t|
    t.name "Any cyclostation"
    t.coordinates Point.from_lon_lat(-99.140496, 19.378269, 4326)
  end
  
end