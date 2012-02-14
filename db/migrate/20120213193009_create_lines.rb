class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :name
      t.string :name_by_directions
      t.integer :transport_id
      t.timestamps
    end
  end
end
