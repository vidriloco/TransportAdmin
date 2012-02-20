class CreateDockingStations < ActiveRecord::Migration
  def change
    create_table :docking_stations do |t|
      t.string :name, :null => false
      t.point :coordinates, :srid => 4326, :with_z => false, :null => false
      t.integer :transport_id
      t.timestamps
    end
  end
end
