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

ActiveRecord::Schema.define(version: 20200417012059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "neighborhood_id"
    t.text "polyline"
    t.bigint "user_id"
    t.datetime "adoption_expiration"
    t.datetime "adopted_since"
    t.index ["neighborhood_id"], name: "index_blocks_on_neighborhood_id"
    t.index ["user_id"], name: "index_blocks_on_user_id"
  end

  create_table "cleanings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "block_id"
    t.datetime "time"
    t.text "note"
    t.string "before_photo"
    t.string "after_photo"
    t.index ["block_id"], name: "index_cleanings_on_block_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "message"
    t.bigint "user_id"
    t.bigint "cleaning_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cleaning_id"], name: "index_comments_on_cleaning_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "configs", force: :cascade do |t|
    t.string "key", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.text "description"
    t.text "location_description", null: false
    t.date "event_date", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.string "photo_url"
    t.bigint "user_id"
    t.bigint "neighborhood_id"
    t.boolean "canceled", default: false, null: false
    t.index ["neighborhood_id"], name: "index_events_on_neighborhood_id"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "neighborhoods", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.text "description"
    t.text "message"
    t.string "photo"
    t.decimal "lat"
    t.decimal "lng"
    t.integer "zoom"
    t.boolean "published", default: false, null: false
  end

  create_table "neighborhoods_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "neighborhood_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "admin", default: false
    t.boolean "subscribed_to_reminders", default: true
    t.boolean "subscribed_to_neighborhood_updates", default: true, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "blocks", "neighborhoods"
  add_foreign_key "blocks", "users"
  add_foreign_key "cleanings", "blocks"
end
