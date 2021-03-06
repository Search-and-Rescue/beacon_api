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

ActiveRecord::Schema.define(version: 2019_10_28_223129) do

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

  create_table "gears", force: :cascade do |t|
    t.string "item_name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.index ["user_id"], name: "index_gears_on_user_id"
  end

  create_table "search_and_rescues", force: :cascade do |t|
    t.string "team_name"
    t.string "county"
    t.string "contact"
    t.string "contact_number"
    t.string "city"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
  end

  create_table "trip_contacts", force: :cascade do |t|
    t.bigint "emergency_contact_id"
    t.bigint "trip_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["emergency_contact_id"], name: "index_trip_contacts_on_emergency_contact_id"
    t.index ["trip_id"], name: "index_trip_contacts_on_trip_id"
  end

  create_table "trip_gears", force: :cascade do |t|
    t.bigint "trip_id"
    t.bigint "gear_id"
    t.string "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gear_id"], name: "index_trip_gears_on_gear_id"
    t.index ["trip_id"], name: "index_trip_gears_on_trip_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.string "starting_point"
    t.string "ending_point"
    t.date "start_date"
    t.datetime "start_time"
    t.date "end_date"
    t.datetime "end_time"
    t.date "notification_date"
    t.datetime "notification_time"
    t.integer "traveling_companions"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "activity_type"
    t.boolean "active", default: true
    t.bigint "vehicle_id"
    t.index ["user_id"], name: "index_trips_on_user_id"
    t.index ["vehicle_id"], name: "index_trips_on_vehicle_id"
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
    t.integer "weight"
    t.string "hair_color"
    t.string "skin_color"
    t.string "gender"
    t.boolean "cosar_card"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "height"
    t.string "birth_date"
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "make"
    t.string "model"
    t.integer "year"
    t.string "color"
    t.string "license_plate"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state"
    t.index ["user_id"], name: "index_vehicles_on_user_id"
  end

  add_foreign_key "emergency_contacts", "users"
  add_foreign_key "gears", "users"
  add_foreign_key "trip_contacts", "emergency_contacts"
  add_foreign_key "trip_contacts", "trips"
  add_foreign_key "trip_gears", "gears"
  add_foreign_key "trip_gears", "trips"
  add_foreign_key "trips", "users"
  add_foreign_key "trips", "vehicles"
  add_foreign_key "vehicles", "users"
end
