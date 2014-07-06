class CreateScheduleTimes < ActiveRecord::Migration
  def change
    create_table :schedule_times do |t|
      t.time :time, null: false
      t.integer :schedule_id, null: false

      t.timestamps
    end
  end
end
