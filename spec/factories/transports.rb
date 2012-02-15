# encoding: utf-8

FactoryGirl.define do
  
  factory :metro, :class => Transport do |t|
    t.name "STC Metro"
    t.web_page "www.metro.df.gob.mx"
    t.twitter "STC_Metro"
    t.mode Transport.mode_for(:subway)
  end
  
  factory :metrobus, :class => Transport do |t|
    t.name "Metrobús"
    t.web_page "www.metrobus.df.gob.mx"
    t.twitter "Metrobus_GDF"
    t.mode Transport.mode_for(:bus_rapid_transit)
  end
  
  factory :ecobici, :class => Transport do |t|
    t.name "Ecobici"
    t.web_page "www.ecobici.df.gob.mx"
    t.twitter "ecobici"
    t.mode Transport.mode_for(:bike_sharing)
  end
  
end