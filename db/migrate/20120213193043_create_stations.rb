class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.point :coordinates, :srid => 4326, :with_z => false 
      t.boolean :is_terminal
      t.references :agrouper, :polymorphic => true
      t.timestamps
    end
  end
end
