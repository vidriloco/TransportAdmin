class Segment < ActiveRecord::Base
  belongs_to :origin_station, :foreign_key => :origin_station_id, :class_name => "Station"
  belongs_to :destination_station, :foreign_key => :destination_station_id, :class_name => "Station"
  belongs_to :line
  
  validate :stations_are_different
  
  validate :has_unique_stations, :on => :create
  validate :has_unique_stations_preserving_id, :on => :update
  
  validates_presence_of :origin_station, :destination_station
  
  private
  def stations_are_different
    if origin_station == destination_station
      self.errors.add(:origin_station)
      self.errors.add(:destination_station)
    end
  end
  
  def has_unique_stations_preserving_id
    conditions = '((origin_station_id = :o_id AND destination_station_id = :d_id) OR (origin_station_id = :d_id AND destination_station_id = :o_id)) AND id <> :id'
    stations_uniqueness_for(conditions)
  end
  
  def has_unique_stations
    conditions = '(origin_station_id = :o_id AND destination_station_id = :d_id) OR (origin_station_id = :d_id AND destination_station_id = :o_id)'
    stations_uniqueness_for(conditions)
  end
  
  def stations_uniqueness_for(conditions)
    if Segment.where(conditions, {:o_id => origin_station_id, :d_id => destination_station_id, :id => id}).count > 0
      self.errors.add(:origin_station)
      self.errors.add(:destination_station)
    end
  end
end
