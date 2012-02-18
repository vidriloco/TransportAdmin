class Line < ActiveRecord::Base
  has_many :ways
  has_many :stations, :as => :agrouper
  has_many :segments
  
  belongs_to :transport
  
  validates_presence_of :name, :right_terminal, :left_terminal, :transport
  
  def name_by_directions
    "#{left_terminal} - #{right_terminal}"
  end
end
