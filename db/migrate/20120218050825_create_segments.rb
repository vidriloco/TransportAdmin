class CreateSegments < ActiveRecord::Migration
  def change
    create_table :segments do |t|
      t.integer :line_id
      t.integer :origin_station_id
      t.integer :destination_station_id
      t.float :distance
      t.boolean :double_direction
      t.timestamps
    end
  end
end
