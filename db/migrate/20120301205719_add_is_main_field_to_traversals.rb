class AddIsMainFieldToTraversals < ActiveRecord::Migration
  def up
    add_column :traversals, :is_main, :boolean, :default => true
  end

  def down
    remove_column :traversals, :is_main
  end
end
