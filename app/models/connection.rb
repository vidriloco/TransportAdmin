class Connection < ActiveRecord::Base
  belongs_to :one_station, :foreign_key => :one_station_id, :class_name => "Station"
  belongs_to :another_station, :foreign_key => :another_station_id, :class_name => "Station"
  
  belongs_to :one_line, :foreign_key => :one_line_id, :class_name => "Line"
  belongs_to :another_line, :foreign_key => :another_line_id, :class_name => "Line"
  
  before_validation :assign_another_station_line
  
  validates_presence_of :one_station, :another_station, :one_line, :another_line 
  
  def self.find_all_from_line(line)
    self.where('one_line_id = ? OR another_line_id = ?', line.id, line.id)
  end
  
  def self.accessibility_opts
    { 1 => :low, 2 => :high}
  end
  
  def self.kind_opts
    { 1 => :internal, 2 => :external }
  end
  
  def self.length_opts
    { 1 => :short, 2 => :medium, 3 => :large }
  end
  
  def self.humanized_opts_for(type)
    opts=self.send("#{type.to_s}_opts")
    results=opts.each_key.inject({}) do |collected, last|
      collected[I18n.t("connections.evaluations.#{type.to_s}.#{opts[last]}")] = last
      collected
    end
    results
  end
  
  private
  def assign_another_station_line
    self.another_line = another_station.agrouper
  end
  
end
