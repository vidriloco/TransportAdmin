class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.integer :identifier
      t.integer :line_id
      t.timestamps
    end
  end
end
