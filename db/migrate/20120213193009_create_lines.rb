class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.string :name, :null => false
      t.string :right_terminal, :null => false
      t.string :left_terminal, :null => false
      t.integer :transport_id, :null => false
      t.string :color
      t.timestamps
    end
    
    add_index :lines, :transport_id, :name => 'transport_id_ix'
    
  end
end
