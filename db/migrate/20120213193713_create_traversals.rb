class CreateTraversals < ActiveRecord::Migration
  def change
    create_table :traversals do |t|
      t.integer :one_station_id
      t.integer :another_station_id
      t.string :description
      t.timestamps
    end
  end
end
