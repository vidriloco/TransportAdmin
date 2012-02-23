class Vehicle < ActiveRecord::Base
  belongs_to :line
  has_many :instants
  
  validates_presence_of :line, :identifier
  validates_uniqueness_of :identifier
  
  def belongs_to_line_transport?
    !line.nil?
  end
end
