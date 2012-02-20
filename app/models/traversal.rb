class Traversal < ActiveRecord::Base
  
  belongs_to :one_station, :foreign_key => :one_station_id, :class_name => "Station"
  belongs_to :another_station, :foreign_key => :another_station_id, :class_name => "Station"
  
  validates_presence_of :one_station, :another_station
  
  validate :stations_are_different
  
  def self.build_new_between(one_station_name, another_station_name, lines_ids)
    lines = lines_ids[:by]
    one_st = Station.first(:conditions => {:name => one_station_name, :line_id => lines})
    another_st = Station.first(:conditions => {:name => another_station_name, :line_id => lines})
    self.new(:one_station => one_st, :another_station => another_st)
  end
  
  def self.build_new_between!(one_station_name, another_station_name, lines_ids)
    traversal=self.build_new_between(one_station_name, another_station_name, lines_ids)
    traversal.save
    traversal
  end
  
  private
  def stations_are_different
    if one_station == another_station
      self.errors.add(:one_station)
      self.errors.add(:another_station)
    end
  end
end
