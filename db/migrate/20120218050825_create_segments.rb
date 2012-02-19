class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.integer :line_id, :null => false
      t.integer :origin_station_id, :null => false
      t.integer :destination_station_id, :null => false
      t.float :distance
      t.boolean :double_direction, :default => false
      t.timestamps
    end
    
    add_index :segments, [:origin_station_id, :destination_station_id, :line_id], :unique => true, :name => 'origin_destination_id_ix'
    add_index :segments, :origin_station_id, :name => 'origin_station_id_ix'
    add_index :segments, :destination_station_id, :name => 'destination_station_id_ix'
  end
end
