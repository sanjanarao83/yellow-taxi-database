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

ActiveRecord::Schema.define(version: 2018_04_12_061736) do

  create_table "borders", primary_key: ["country1", "country2"], force: :cascade do |t|
    t.string "country1", limit: 4, null: false
    t.string "country2", limit: 4, null: false
    t.decimal "length"
  end

  create_table "city", primary_key: ["name", "country", "province"], force: :cascade do |t|
    t.string "name", limit: 40, null: false
    t.string "country", limit: 4, null: false
    t.string "province", limit: 40, null: false
    t.decimal "population"
    t.decimal "longitude"
    t.decimal "latitude"
    t.decimal "elevation"
  end

  create_table "city_names", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "continent", primary_key: "name", id: :string, limit: 20, force: :cascade do |t|
    t.integer "area", limit: 10, precision: 10
  end

  create_table "country", primary_key: "code", id: :string, limit: 4, force: :cascade do |t|
    t.string "name", limit: 40, null: false
    t.string "capital", limit: 40
    t.string "province", limit: 40
    t.decimal "area"
    t.decimal "population"
    t.index ["name"], name: "sys_c00581047", unique: true
  end

# Could not dump table "desert" because of following StandardError
#   Unknown type 'SG4.GEOCOORD' for column 'coordinates'

  create_table "economy", primary_key: "country", id: :string, limit: 4, force: :cascade do |t|
    t.decimal "gdp"
    t.decimal "agriculture"
    t.decimal "service"
    t.decimal "industry"
    t.decimal "inflation"
  end

  create_table "encompasses", primary_key: ["country", "continent"], force: :cascade do |t|
    t.string "country", limit: 4, null: false
    t.string "continent", limit: 20, null: false
    t.decimal "percentage"
  end

  create_table "ethnicgroup", primary_key: ["name", "country"], force: :cascade do |t|
    t.string "country", limit: 4, null: false
    t.string "name", limit: 50, null: false
    t.decimal "percentage"
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

  create_table "geo_desert", primary_key: ["province", "country", "desert"], force: :cascade do |t|
    t.string "desert", limit: 40, null: false
    t.string "country", limit: 4, null: false
    t.string "province", limit: 40, null: false
  end

  create_table "geo_estuary", primary_key: ["province", "country", "river"], force: :cascade do |t|
    t.string "river", limit: 40, null: false
    t.string "country", limit: 4, null: false
    t.string "province", limit: 40, null: false
  end

  create_table "geo_island", primary_key: ["province", "country", "island"], force: :cascade do |t|
    t.string "island", limit: 40, null: false
    t.string "country", limit: 4, null: false
    t.string "province", limit: 40, null: false
  end

  create_table "geo_lake", primary_key: ["province", "country", "lake"], force: :cascade do |t|
    t.string "lake", limit: 40, null: false
    t.string "country", limit: 4, null: false
    t.string "province", limit: 40, null: false
  end

  create_table "geo_mountain", primary_key: ["province", "country", "mountain"], force: :cascade do |t|
    t.string "mountain", limit: 40, null: false
    t.string "country", limit: 4, null: false
    t.string "province", limit: 40, null: false
  end

  create_table "geo_river", primary_key: ["province", "country", "river"], force: :cascade do |t|
    t.string "river", limit: 40, null: false
    t.string "country", limit: 4, null: false
    t.string "province", limit: 40, null: false
  end

  create_table "geo_sea", primary_key: ["province", "country", "sea"], force: :cascade do |t|
    t.string "sea", limit: 40, null: false
    t.string "country", limit: 4, null: false
    t.string "province", limit: 40, null: false
  end

  create_table "geo_source", primary_key: ["province", "country", "river"], force: :cascade do |t|
    t.string "river", limit: 40, null: false
    t.string "country", limit: 4, null: false
    t.string "province", limit: 40, null: false
  end

# Could not dump table "island" because of following StandardError
#   Unknown type 'SG4.GEOCOORD' for column 'coordinates'

  create_table "islandin", id: false, force: :cascade do |t|
    t.string "island", limit: 40
    t.string "sea", limit: 40
    t.string "lake", limit: 40
    t.string "river", limit: 40
  end

  create_table "ismember", primary_key: ["country", "organization"], force: :cascade do |t|
    t.string "country", limit: 4, null: false
    t.string "organization", limit: 12, null: false
    t.string "type", limit: 40, default: "member"
  end

# Could not dump table "lake" because of following StandardError
#   Unknown type 'SG4.GEOCOORD' for column 'coordinates'

  create_table "language", primary_key: ["name", "country"], force: :cascade do |t|
    t.string "country", limit: 4, null: false
    t.string "name", limit: 50, null: false
    t.decimal "percentage"
  end

  create_table "located", id: false, force: :cascade do |t|
    t.string "city", limit: 40
    t.string "province", limit: 40
    t.string "country", limit: 4
    t.string "river", limit: 40
    t.string "lake", limit: 40
    t.string "sea", limit: 40
  end

  create_table "locatedon", primary_key: ["city", "province", "country", "island"], force: :cascade do |t|
    t.string "city", limit: 40, null: false
    t.string "province", limit: 40, null: false
    t.string "country", limit: 4, null: false
    t.string "island", limit: 40, null: false
  end

  create_table "mergeswith", primary_key: ["sea1", "sea2"], force: :cascade do |t|
    t.string "sea1", limit: 40, null: false
    t.string "sea2", limit: 40, null: false
  end

# Could not dump table "mountain" because of following StandardError
#   Unknown type 'SG4.GEOCOORD' for column 'coordinates'

  create_table "mountainonisland", primary_key: ["mountain", "island"], force: :cascade do |t|
    t.string "mountain", limit: 40, null: false
    t.string "island", limit: 40, null: false
  end

  create_table "movie", primary_key: "movie_id", force: :cascade do |t|
    t.string "title", limit: 30, null: false
    t.string "genre", limit: 10, null: false
    t.integer "runtime", precision: 38
    t.integer "yr", precision: 38
    t.integer "budget", precision: 38
    t.integer "sell", precision: 38
    t.string "director", limit: 20
  end

  create_table "organization", primary_key: "abbreviation", id: :string, limit: 12, force: :cascade do |t|
    t.string "name", limit: 80, null: false
    t.string "city", limit: 40
    t.string "country", limit: 4
    t.string "province", limit: 40
    t.date "established"
    t.index ["name"], name: "orgnameunique", unique: true
  end

  create_table "politics", primary_key: "country", id: :string, limit: 4, force: :cascade do |t|
    t.date "independence"
    t.string "wasdependent", limit: 40
    t.string "dependent", limit: 4
    t.string "government", limit: 120
  end

  create_table "population", primary_key: "country", id: :string, limit: 4, force: :cascade do |t|
    t.decimal "population_growth"
    t.decimal "infant_mortality"
  end

  create_table "province", primary_key: ["name", "country"], force: :cascade do |t|
    t.string "name", limit: 40, null: false
    t.string "country", limit: 4, null: false
    t.decimal "population"
    t.decimal "area"
    t.string "capital", limit: 40
    t.string "capprov", limit: 40
  end

  create_table "religion", primary_key: ["name", "country"], force: :cascade do |t|
    t.string "country", limit: 4, null: false
    t.string "name", limit: 50, null: false
    t.decimal "percentage"
  end

# Could not dump table "river" because of following StandardError
#   Unknown type 'SG4.GEOCOORD' for column 'source'

  create_table "riverthrough", primary_key: ["river", "lake"], force: :cascade do |t|
    t.string "river", limit: 40, null: false
    t.string "lake", limit: 40, null: false
  end

  create_table "sea", primary_key: "name", id: :string, limit: 40, force: :cascade do |t|
    t.decimal "depth"
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

  add_foreign_key "borders", "country", column: "country1", primary_key: "code", name: "fk_country1"
  add_foreign_key "borders", "country", column: "country2", primary_key: "code", name: "fk_country2"
  add_foreign_key "city", "province", column: "country", primary_key: "country", name: "fk_provincecity"
  add_foreign_key "city", "province", column: "province", primary_key: "name", name: "fk_provincecity"
  add_foreign_key "economy", "country", column: "country", primary_key: "code", name: "fk_countryecon"
  add_foreign_key "encompasses", "continent", column: "continent", primary_key: "name", name: "fk_continent"
  add_foreign_key "encompasses", "country", column: "country", primary_key: "code", name: "fk_countryenc"
  add_foreign_key "ethnicgroup", "country", column: "country", primary_key: "code", name: "fk_countryethnic"
  add_foreign_key "geo_desert", "province", column: "country", primary_key: "country", name: "fk_prvdst"
  add_foreign_key "geo_desert", "province", column: "province", primary_key: "name", name: "fk_prvdst"
  add_foreign_key "geo_estuary", "province", column: "country", primary_key: "country", name: "fk_prvest"
  add_foreign_key "geo_estuary", "province", column: "province", primary_key: "name", name: "fk_prvest"
  add_foreign_key "geo_island", "province", column: "country", primary_key: "country", name: "fk_prvisl"
  add_foreign_key "geo_island", "province", column: "province", primary_key: "name", name: "fk_prvisl"
  add_foreign_key "geo_lake", "province", column: "country", primary_key: "country", name: "fk_prvlake"
  add_foreign_key "geo_lake", "province", column: "province", primary_key: "name", name: "fk_prvlake"
  add_foreign_key "geo_mountain", "province", column: "country", primary_key: "country", name: "fk_prvmnt"
  add_foreign_key "geo_mountain", "province", column: "province", primary_key: "name", name: "fk_prvmnt"
  add_foreign_key "geo_river", "province", column: "country", primary_key: "country", name: "fk_prvrvr"
  add_foreign_key "geo_river", "province", column: "province", primary_key: "name", name: "fk_prvrvr"
  add_foreign_key "geo_sea", "province", column: "country", primary_key: "country", name: "fk_prvsea"
  add_foreign_key "geo_sea", "province", column: "province", primary_key: "name", name: "fk_prvsea"
  add_foreign_key "geo_source", "province", column: "country", primary_key: "country", name: "fk_prvsrc"
  add_foreign_key "geo_source", "province", column: "province", primary_key: "name", name: "fk_prvsrc"
  add_foreign_key "islandin", "island", column: "island", primary_key: "name", name: "fk_islin"
  add_foreign_key "islandin", "lake", column: "lake", primary_key: "name", name: "fk_lakein"
  add_foreign_key "islandin", "river", column: "river", primary_key: "name", name: "fk_rvrin"
  add_foreign_key "islandin", "sea", column: "sea", primary_key: "name", name: "fk_seain"
  add_foreign_key "ismember", "country", column: "country", primary_key: "code", name: "fk_countrymemb"
  add_foreign_key "ismember", "organization", column: "organization", primary_key: "abbreviation", name: "fk_orgmemb"
  add_foreign_key "language", "country", column: "country", primary_key: "code", name: "fk_countrylang"
  add_foreign_key "located", "city", column: "city", primary_key: "name", name: "fk_prvloc"
  add_foreign_key "located", "city", column: "country", primary_key: "country", name: "fk_prvloc"
  add_foreign_key "located", "city", column: "province", primary_key: "province", name: "fk_prvloc"
  add_foreign_key "locatedon", "city", column: "city", primary_key: "name", name: "fk_cityloc"
  add_foreign_key "locatedon", "city", column: "country", primary_key: "country", name: "fk_cityloc"
  add_foreign_key "locatedon", "city", column: "province", primary_key: "province", name: "fk_cityloc"
  add_foreign_key "mergeswith", "sea", column: "sea1", primary_key: "name", name: "fk_sea1"
  add_foreign_key "mergeswith", "sea", column: "sea2", primary_key: "name", name: "fk_sea2"
  add_foreign_key "mountainonisland", "island", column: "island", primary_key: "name", name: "fk_islisl"
  add_foreign_key "mountainonisland", "mountain", column: "mountain", primary_key: "name", name: "fk_mntisl"
  add_foreign_key "organization", "city", column: "city", primary_key: "name", name: "fk_cityorg"
  add_foreign_key "organization", "city", column: "country", primary_key: "country", name: "fk_cityorg"
  add_foreign_key "organization", "city", column: "province", primary_key: "province", name: "fk_cityorg"
  add_foreign_key "politics", "country", column: "country", primary_key: "code", name: "fk_countryplc"
  add_foreign_key "population", "country", column: "country", primary_key: "code", name: "fk_countrypop"
  add_foreign_key "province", "country", column: "country", primary_key: "code", name: "fk_countryprovince"
  add_foreign_key "religion", "country", column: "country", primary_key: "code", name: "fk_countryreligion"
  add_foreign_key "river", "lake", column: "lake", primary_key: "name", name: "fk_lakeriver"
  add_foreign_key "river", "sea", column: "sea", primary_key: "name", name: "fk_seariver"
  add_foreign_key "riverthrough", "lake", column: "lake", primary_key: "name", name: "fk_lake"
  add_foreign_key "riverthrough", "river", column: "river", primary_key: "name", name: "fk_rvr"
end
