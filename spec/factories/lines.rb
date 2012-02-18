# encoding: utf-8

FactoryGirl.define do
  
  factory :blue_line, :class => Line do |t|
    t.name "Línea 1"
    t.right_terminal "Pantitlán"
    t.left_terminal "Observatorio"
    t.color "#344C99"
  end
  
  factory :red_line, :class => Line do |t|
    t.name "Línea 6"
    t.right_terminal "Martin Carrera"
    t.left_terminal "El Rosario"
    t.color "#993434"
  end
  
  factory :brown_line, :class => Line do |t|
    t.name "Línea 9"
    t.right_terminal "Pantitlán"
    t.left_terminal "Tacubaya"
    t.color "#492505"
  end
  
end