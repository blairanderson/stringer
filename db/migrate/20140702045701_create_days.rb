class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :number
      t.string :short
      t.string :long

      t.timestamps
    end
  end
end
