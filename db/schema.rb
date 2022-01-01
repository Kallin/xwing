# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_01_01_230244) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "actions_ships", id: false, force: :cascade do |t|
    t.bigint "ship_id", null: false
    t.bigint "action_id", null: false
  end

  create_table "collections", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "factions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "factions_ships", id: false, force: :cascade do |t|
    t.bigint "ship_id", null: false
    t.bigint "faction_id", null: false
  end

  create_table "pilots", force: :cascade do |t|
    t.string "name"
    t.bigint "ship_id", null: false
    t.integer "initiative"
    t.boolean "limited"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ship_id"], name: "index_pilots_on_ship_id"
  end

  create_table "ship_counts", force: :cascade do |t|
    t.bigint "ship_id", null: false
    t.bigint "collection_id", null: false
    t.integer "count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["collection_id"], name: "index_ship_counts_on_collection_id"
    t.index ["ship_id"], name: "index_ship_counts_on_ship_id"
  end

  create_table "ships", force: :cascade do |t|
    t.string "name"
    t.integer "attack"
    t.integer "hull"
    t.integer "shields"
    t.integer "agility"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "energy"
  end

  create_table "upgrade_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "upgrade_types_upgrades", id: false, force: :cascade do |t|
    t.bigint "upgrade_id", null: false
    t.bigint "upgrade_type_id", null: false
  end

  create_table "upgrades", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: 6
    t.datetime "remember_created_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "collections", "users"
  add_foreign_key "pilots", "ships"
  add_foreign_key "ship_counts", "collections"
  add_foreign_key "ship_counts", "ships"
end
