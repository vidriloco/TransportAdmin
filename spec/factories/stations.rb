# encoding: utf-8

FactoryGirl.define do
  
  factory :cyclostation, :class => Station do |t|
    t.name "Any cyclostation"
  end
  
  factory :observatorio, :class => Station do |t|
    t.name "Observatorio"
  end
  
  factory :tacubaya, :class => Station do |t|
    t.name "Tacubaya"
  end
  
  factory :station do |t|
    t.name "Station example"
    t.coordinates Point.from_lon_lat(-99.140496, 19.378269, 4326)
  end
  
end