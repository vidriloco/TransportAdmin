class CreateTransports < ActiveRecord::Migration
  def change
    create_table :transports do |t|
      t.string :name 
      t.string :twitter
      t.string :web_page
      t.integer :mode
      t.timestamps
    end
  end
end
