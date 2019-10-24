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

ActiveRecord::Schema.define(version: 2019_10_24_034726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "emergency_contacts", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_emergency_contacts_on_user_id"
  end

  create_table "trip_contacts", force: :cascade do |t|
    t.bigint "emergency_contact_id"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emergency_contact_id"], name: "index_trip_contacts_on_emergency_contact_id"
    t.index ["trip_id"], name: "index_trip_contacts_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.string "starting_point"
    t.string "ending_point"
    t.date "start_date"
    t.time "start_time"
    t.date "end_date"
    t.time "end_time"
    t.date "notification_date"
    t.time "notification_time"
    t.integer "traveling_companions"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_trips_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.integer "zip"
    t.string "phone"
    t.string "email"
    t.string "password_digest"
    t.string "allergies"
    t.integer "experience_level"
    t.integer "age"
    t.integer "weight"
    t.string "hair_color"
    t.string "skin_color"
    t.string "gender"
    t.boolean "cosar_card"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "emergency_contacts", "users"
  add_foreign_key "trip_contacts", "emergency_contacts"
  add_foreign_key "trip_contacts", "trips"
  add_foreign_key "trips", "users"
end
