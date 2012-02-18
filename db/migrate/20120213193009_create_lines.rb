class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :name
      t.string :right_terminal
      t.string :left_terminal
      t.integer :transport_id
      t.string :color
      t.timestamps
    end
  end
end
