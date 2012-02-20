class Station < ActiveRecord::Base  
  include Models::GeographySupport
  
  belongs_to :line
  has_many :segments
  has_many :connections
  
  validates_presence_of :name, :coordinates, :line
    
  attr_accessible :name, :line_id, :is_terminal, :coordinates
  
end
