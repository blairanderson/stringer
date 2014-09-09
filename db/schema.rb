# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140908005935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "feeds", force: true do |t|
    t.string   "name"
    t.text     "url",                      null: false
    t.datetime "last_fetched"
    t.integer  "status_cd",    default: 0, null: false
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feeds", ["url"], name: "index_feeds_on_url", unique: true, using: :btree

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.integer  "user_id",                null: false
    t.text     "content"
    t.integer  "status_cd",  default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["status_cd"], name: "index_messages_on_status_cd", using: :btree
  add_index "messages", ["user_id", "status_cd"], name: "index_messages_on_user_id_and_status_cd", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "schedule_times", force: true do |t|
    t.time     "time",        null: false
    t.integer  "schedule_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedule_times", ["schedule_id"], name: "index_schedule_times_on_schedule_id", using: :btree

  create_table "schedules", force: true do |t|
    t.integer  "user_id"
    t.integer  "sunday_cd",    default: 0, null: false
    t.integer  "monday_cd",    default: 0, null: false
    t.integer  "tuesday_cd",   default: 0, null: false
    t.integer  "wednesday_cd", default: 0, null: false
    t.integer  "thursday_cd",  default: 0, null: false
    t.integer  "friday_cd",    default: 0, null: false
    t.integer  "saturday_cd",  default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["friday_cd"], name: "index_schedules_on_friday_cd", using: :btree
  add_index "schedules", ["monday_cd"], name: "index_schedules_on_monday_cd", using: :btree
  add_index "schedules", ["saturday_cd"], name: "index_schedules_on_saturday_cd", using: :btree
  add_index "schedules", ["sunday_cd"], name: "index_schedules_on_sunday_cd", using: :btree
  add_index "schedules", ["thursday_cd"], name: "index_schedules_on_thursday_cd", using: :btree
  add_index "schedules", ["tuesday_cd"], name: "index_schedules_on_tuesday_cd", using: :btree
  add_index "schedules", ["user_id"], name: "index_schedules_on_user_id", using: :btree
  add_index "schedules", ["wednesday_cd"], name: "index_schedules_on_wednesday_cd", using: :btree

  create_table "stories", force: true do |t|
    t.text     "title"
    t.text     "permalink"
    t.text     "body"
    t.integer  "feed_id",                    null: false
    t.text     "entry_id"
    t.datetime "published"
    t.boolean  "is_read",    default: false, null: false
    t.boolean  "is_starred", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "stories", ["feed_id"], name: "index_stories_on_feed_id", using: :btree

  create_table "user_feeds", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "feed_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_feeds", ["feed_id"], name: "index_user_feeds_on_feed_id", using: :btree
  add_index "user_feeds", ["user_id", "feed_id"], name: "index_user_feeds_on_user_id_and_feed_id", unique: true, using: :btree
  add_index "user_feeds", ["user_id"], name: "index_user_feeds_on_user_id", using: :btree

  create_table "user_stories", force: true do |t|
    t.integer  "user_id"
    t.integer  "story_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_stories", ["story_id"], name: "index_user_stories_on_story_id", using: :btree
  add_index "user_stories", ["user_id", "story_id"], name: "index_user_stories_on_user_id_and_story_id", unique: true, using: :btree
  add_index "user_stories", ["user_id"], name: "index_user_stories_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "time_zone",              default: "UTC", null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
