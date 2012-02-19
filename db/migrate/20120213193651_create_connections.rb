class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.integer :one_station_id, :null => false
      t.integer :another_station_id, :null => false
      t.integer :one_line_id, :null => false
      t.integer :another_line_id, :null => false
      t.integer :length
      t.integer :accessibility
      t.integer :kind
      t.timestamps
    end
    
    add_index(:connections, [:one_station_id, :another_station_id, :one_line_id, :another_line_id], :unique => true, :name => 'stations_lines_id_ix')
    add_index :connections, :one_line_id, :name => 'one_line_id_ix'
    add_index :connections, :another_line_id, :name => 'another_line_id_ix'
    add_index :connections, :one_station_id, :name => 'one_station_id_ix'
    add_index :connections, :another_station_id, :name => 'another_station_id_ix'
  end
end
