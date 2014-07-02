class CreateScheduleDays < ActiveRecord::Migration
  def change
    create_table :schedule_days do |t|
      t.boolean :active, default: true, null: false
      t.references :day, index: true, null: false
      t.references :schedule, index: true, null: false

      t.timestamps
    end
    add_index :schedule_days, [:day_id, :schedule_id], unique: true, using: :btree
  end
end
