class CreateTraversals < ActiveRecord::Migration
  def change
    create_table :traversals do |t|

      t.timestamps
    end
  end
end
