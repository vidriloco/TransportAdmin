class CreatePartitions < ActiveRecord::Migration
  def change
    create_table :partitions do |t|
      t.string :name
      t.integer :transport_id
      t.timestamps
    end
  end
end
