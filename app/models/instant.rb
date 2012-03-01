# encoding: utf-8
class Instant < ActiveRecord::Base
  belongs_to :vehicle
  
  def self.to_csv(conditions)
    instants = Instant.find(conditions)
    
    File.open("output.csv", "w") do |file|
       file << "Velocidad, Fecha, Latitud, Longitud, Antiguo, Tiene la calidad mas alta, Identificador del vehículo \n"
       instants.each do |instant|
         file << "#{instant.speed}, #{instant.created_at}, #{instant.coordinates.lat}, #{instant.coordinates.lon}, #{instant.is_old}, #{instant.has_highest_quality}, #{instant.vehicle.identifier} \n"
       end
    end
  end
end
