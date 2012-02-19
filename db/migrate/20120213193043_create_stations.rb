class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name, :null => false
      t.point :coordinates, :srid => 4326, :with_z => false, :null => false
      t.boolean :is_terminal
      t.references :agrouper, :polymorphic => true, :null => false
      t.timestamps
    end
  end
end
