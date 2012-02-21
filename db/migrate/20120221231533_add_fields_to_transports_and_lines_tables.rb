class AddFieldsToTransportsAndLinesTables < ActiveRecord::Migration
  def up
    add_column :transports, :popular_name, :string
    add_column :lines, :simple_identifier, :string
    add_column :transports, :merge_stations_with_same_name, :boolean, :default => false
  end

  def down
    remove_column :accounts, :ssl_enabled
  end
end
