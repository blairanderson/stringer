class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.text :url, null: false
      t.datetime :last_fetched
      t.integer :status
      t.integer :group_id

      t.timestamps
    end
    add_index :feeds, :url, unique: true, using: :btree
  end
end
