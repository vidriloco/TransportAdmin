class CreateTransports < ActiveRecord::Migration
  def change
    create_table :transports do |t|
      t.string :name, :null => false 
      t.string :twitter
      t.string :web_page
      t.integer :mode, :null => false
      t.timestamps
    end
  end
end
