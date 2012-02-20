class Transport < ActiveRecord::Base
  has_many :lines
  has_many :docking_stations
  
  validates_presence_of :name, :mode
  
  def self.modes
    { 1 => :bike_sharing, 2 => :subway, 3 => :bus_rapid_transit, 4 => :bus, 5 => :light_tram}
  end
  
  def self.humanized_modes
    self.modes.keys.each.inject({}) { |collected, key| collected[key] = self.modes[key].to_s.humanize ; collected }
  end
  
  def self.mode_for(mode)
    self.modes.invert[mode]
  end
  
  def humanized_mode
    Transport.modes[self.mode].to_s.humanize
  end
  
  def transport_mode_is?(mode)
    return self.mode==Transport.mode_for(mode)
  end
end
