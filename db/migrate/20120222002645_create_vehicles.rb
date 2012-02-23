class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.column :identifier, :bigint
      t.string :description
      t.integer :line_id
      t.datetime :created_at
    end
    
    change_column :vehicles, :id, :bigint
    add_index :vehicles, :identifier, :name => "vehicles_identifier", :unique => true
    add_index :vehicles, :id, :name => "vehicles_pk", :primary => true
  end
end
