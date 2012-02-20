class CreateTimeTables < ActiveRecord::Migration
  def change
    create_table :time_tables do |t|
      t.time :saturday_start
      t.time :saturday_end
      t.time :sunday_start
      t.time :sunday_end
      t.time :weekday_start
      t.time :weekday_end
      t.integer :traversal_id
      t.timestamps
    end
  end
end
