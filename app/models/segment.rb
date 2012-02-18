class Segment < ActiveRecord::Base
  belongs_to :origin_station, :foreign_key => :origin_station_id, :class_name => "Station"
  belongs_to :destination_station, :foreign_key => :destination_station_id, :class_name => "Station"
  belongs_to :line
  
  validate :different_stations
  
  private
  def different_stations
    if origin_station == destination_station
      self.errors.add(:origin_station)
      self.errors.add(:destination_station)
    end
  end
end
