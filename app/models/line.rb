class Line < ActiveRecord::Base
  has_many :ways
  has_many :stations
  has_many :segments
  has_many :vehicles
  
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
  
  def can_generate_basic_traversals?
    get_terminals.length==2
  end
  
  def basic_traversals
    one_st, another_st = get_terminals
    return [] if one_st.nil? && another_st.nil?
    
    Traversal.where('(one_station_id = :s1 AND another_station_id = :s2) OR (one_station_id = :s2 AND another_station_id = :s1)', 
      {:s1 => one_st, :s2 => another_st})
  end
  
  def generate_basic_traversals
    Traversal.build_new_between!(right_terminal, left_terminal, :by => id)
    Traversal.build_new_between!(left_terminal, right_terminal, :by => id)
  end
  
  private
  
  def get_terminals
    Station.where('(name = :name_right OR name = :name_left) AND line_id = :line_id', {:name_right => right_terminal, :name_left => left_terminal, :line_id => id})
  end
end
