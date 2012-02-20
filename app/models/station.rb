class Station < ActiveRecord::Base  
  include Models::GeographySupport
  belongs_to :agrouper, :polymorphic => true
  has_many :segments
  has_many :connections
  
  validates_presence_of :name, :coordinates, :agrouper
    
  attr_accessible :name, :agrouper_id, :agrouper_type, :is_terminal, :coordinates
  
end
