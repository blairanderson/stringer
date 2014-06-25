class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.text :title
      t.text :permalink
      t.text :body
      t.integer :feed_id, null: false
      t.datetime :published
      t.boolean :is_read, null: false, default: false
      t.boolean :is_starred, null:false, default: false

      t.timestamps
    end
    add_index :stories, :feed_id
  end
end
