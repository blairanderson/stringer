class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id, null: false
      t.text :content
      t.integer :status_cd, null: false, default: 0

      t.timestamps
    end
    add_index :messages, :user_id
    add_index :messages, :status_cd
    add_index :messages, [:user_id, :status_cd]
  end
end
