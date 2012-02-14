# encoding: utf-8

FactoryGirl.define do
  
  factory :blue_line, :class => Line do |t|
    t.name "Línea 1"
    t.name_by_directions "www.metro.df.gob.mx"
  end
  
  factory :red_line, :class => Line do |t|
    t.name "Línea 6"
    t.name_by_directions "www.metrobus.df.gob.mx"
  end
  
end