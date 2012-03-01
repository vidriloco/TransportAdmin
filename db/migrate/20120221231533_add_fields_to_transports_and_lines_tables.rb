class AddFieldsToTransportsAndLinesTables < ActiveRecord::Migration
  def up
    add_column :transports, :popular_name, :string
    add_column :lines, :simple_identifier, :string
    add_column :transports, :merge_stations_with_same_name, :boolean, :default => false
  end

  def down
    remove_column :transports, :popular_name
    remove_column :lines, :simple_identifier
    remove_column :transports, :merge_stations_with_same_name
  end
end
