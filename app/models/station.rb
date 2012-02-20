class Station < ActiveRecord::Base  
  include Models::GeographySupport
  include Models::HumanizatorSupport
  
  has_many :segments
  has_many :connections
  has_many :traversals
  belongs_to :line
  
  validates_presence_of :name, :coordinates, :line
    
  attr_accessible :name, :line_id, :is_terminal, :coordinates, :is_accessible, :bike_parking
  
  
  def self.bike_parking_opts
    { 1 => :internal, 2 => :external, 3 => :none }
  end
end
