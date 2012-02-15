class Line < ActiveRecord::Base
  has_many :ways
  belongs_to :transport
  
  validates_presence_of :name, :name_by_directions, :transport
end
