class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :user_id
      t.integer :sunday_cd, default: 0, null: false
      t.integer :monday_cd, default: 0, null: false
      t.integer :tuesday_cd, default: 0, null: false
      t.integer :wednesday_cd, default: 0, null: false
      t.integer :thursday_cd, default: 0, null: false
      t.integer :friday_cd, default: 0, null: false
      t.integer :saturday_cd, default: 0, null: false

      t.timestamps
    end

    add_index :schedules, :user_id
    add_index :schedules, :sunday_cd
    add_index :schedules, :monday_cd
    add_index :schedules, :tuesday_cd
    add_index :schedules, :wednesday_cd
    add_index :schedules, :thursday_cd
    add_index :schedules, :friday_cd
    add_index :schedules, :saturday_cd
  end
end
