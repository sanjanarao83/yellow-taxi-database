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

ActiveRecord::Schema.define(version: 20180411222305) do

  create_table "employee", primary_key: "empid", force: :cascade do |t|
    t.string "first_name", limit: 100
    t.string "last_name", limit: 100
    t.string "user_name", limit: 150
    t.string "emp_password", limit: 150
    t.string "contact", limit: 10
    t.string "email", limit: 100
    t.string "emp_type", limit: 5
  end

  create_table "fare_data", primary_key: "recordid", force: :cascade do |t|
    t.float "tip_amount", limit: 126
    t.float "extra", limit: 126
    t.float "mta_tax", limit: 126
    t.integer "rate_code", precision: 38
    t.float "tolls_amount", limit: 126
    t.float "total_amount", limit: 126
    t.float "fare_amount", limit: 126
    t.float "imp_surcharge", limit: 126
    t.integer "payment_type", precision: 38
  end

  create_table "fares", force: :cascade do |t|
    t.integer "recordid", precision: 38
    t.float "tip_amount"
    t.float "extra"
    t.float "mta_tax"
    t.integer "ratecodeid", precision: 38
    t.float "tolls_amount"
    t.float "total_amount"
    t.float "fare_amount"
    t.float "improvement_surcharge"
    t.integer "payment_type", precision: 38
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favourites", primary_key: "favid", force: :cascade do |t|
    t.binary "fav_query"
    t.integer "empid", precision: 38
  end

  create_table "trip_data", primary_key: "recordid", force: :cascade do |t|
    t.integer "vendorid", precision: 38
    t.datetime "pickup_datetime", precision: 6
    t.datetime "dropoff_datetime", precision: 6
    t.integer "passenger_count", precision: 38
    t.float "trip_distance", limit: 126
    t.string "store_and_fwd_flag", limit: 1
  end

  create_table "trips", force: :cascade do |t|
    t.integer "recordid", precision: 38
    t.integer "vendorid", precision: 38
    t.datetime "pickup_datetime", precision: 6
    t.datetime "dropoff_datetime", precision: 6
    t.integer "passenger_count", precision: 38
    t.float "trip_distance"
    t.string "store_and_fwd_flag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "favourites", "employee", column: "empid", primary_key: "empid", name: "sys_c00556186"
end
