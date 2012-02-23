# encoding: utf-8

FactoryGirl.define do
  
  factory :vehicle, :class => Vehicle do |t|
    t.identifier 30
    t.description "A complete bus description"
  end
  
end