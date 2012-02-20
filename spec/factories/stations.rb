# encoding: utf-8

FactoryGirl.define do
  
  factory :observatorio, :class => Station do |t|
    t.name "Observatorio"
    t.coordinates Point.from_lon_lat(-99.240496, 19.358269, 4326)
  end
  
  factory :tacubaya, :class => Station do |t|
    t.name "Tacubaya"
    t.coordinates Point.from_lon_lat(-99.280496, 19.378269, 4326)
  end
  
  factory :station do |t|
    t.name "Station example"
    t.coordinates Point.from_lon_lat(-99.140496, 19.378269, 4326)
  end
  
end