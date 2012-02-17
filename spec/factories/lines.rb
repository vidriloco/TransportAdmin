# encoding: utf-8

FactoryGirl.define do
  
  factory :blue_line, :class => Line do |t|
    t.name "Línea 1"
    t.name_by_directions "Observatorio - Pantitlán"
    t.color "#344C99"
  end
  
  factory :red_line, :class => Line do |t|
    t.name "Línea 6"
    t.name_by_directions "Martin Carrera - El Rosario"
    t.color "#993434"
  end
  
end