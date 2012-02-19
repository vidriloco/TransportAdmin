class Line < ActiveRecord::Base
  has_many :ways
  has_many :stations, :as => :agrouper
  has_many :segments
  
  belongs_to :transport
  
  validates_presence_of :name, :right_terminal, :left_terminal, :transport
  
  def self.all_except(line)
    self.where('id != ?', line.id)
  end
  
  def connections
    Connection.find_all_from_line(self)
  end
  
  def line_transport
    "#{self.transport.name} - #{self.name}"
  end
  
  def name_by_directions
    "#{left_terminal} - #{right_terminal}"
  end
end
