class CreateWays < ActiveRecord::Migration
  def change
    create_table :ways do |t|
      t.line_string :content, :srid => 4326, :null => false
      t.string :description
      t.integer :line_id, :null => false
      t.timestamps
    end
    
    add_index :ways, :line_id, :name => 'line_id_ix'
  end
end
