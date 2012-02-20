class DockingStation < ActiveRecord::Base  
  include Models::GeographySupport
  
  validates_presence_of :coordinates, :name
  
  belongs_to :transport
end
