class CreateWays < ActiveRecord::Migration
  def change
    create_table :ways do |t|
      t.line_string :content, :srid => 4326
      t.string :description
      t.integer :line_id
      t.timestamps
    end
  end
end
