class CreateScheduleTrackers < ActiveRecord::Migration
  def change
    create_table :schedule_trackers do |t|
      t.integer :hour, null: false
      t.integer :minute, null: false
      t.integer :attempts, null: false, default: 0
      t.datetime :completed_at

      t.timestamps
    end
    add_index :schedule_trackers, :hour
    add_index :schedule_trackers, :minute
  end
end
