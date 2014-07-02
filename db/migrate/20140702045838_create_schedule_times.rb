class CreateScheduleTimes < ActiveRecord::Migration
  def change
    create_table :schedule_times do |t|
      t.time :time
      t.references :schedule, index: true

      t.timestamps
    end
  end
end
