class Station < ActiveRecord::Base  
  belongs_to :agrouper, :polymorphic => true
  has_many :segments
  has_many :connections
  
  validates_presence_of :name, :coordinates, :agrouper
    
  attr_accessible :name, :agrouper_id, :agrouper_type, :is_terminal, :coordinates

  def apply_geo(coordinates)
    return self if coordinates.nil? || (coordinates["lon"].blank? || coordinates["lat"].blank?)
    self.coordinates = Point.from_lon_lat(coordinates["lon"].to_f, coordinates["lat"].to_f, 4326)
    self
  end
  
end
