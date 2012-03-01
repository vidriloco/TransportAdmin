class CreateInstants < ActiveRecord::Migration
  def change
    create_table :instants do |t|
      t.float :speed
      t.point :coordinates, :srid => 4326, :with_z => false, :null => false
      t.boolean :is_old
      t.boolean :has_highest_quality
      
      t.integer :vehicle_id
      t.datetime :created_at
    end
  end
end
