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

ActiveRecord::Schema.define(version: 20170720082445) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "pet_lists", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pet_lists_pets", force: :cascade do |t|
    t.integer  "score"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "pet_id"
    t.integer  "pet_list_id"
    t.index ["pet_id"], name: "index_pet_lists_pets_on_pet_id", using: :btree
    t.index ["pet_list_id"], name: "index_pet_lists_pets_on_pet_list_id", using: :btree
  end

  create_table "pet_lists_pets_pets", id: false, force: :cascade do |t|
    t.integer "pet_lists_pet_id", null: false
    t.integer "pet_id",           null: false
  end

  create_table "pet_lists_users", id: false, force: :cascade do |t|
    t.integer "pet_list_id", null: false
    t.integer "user_id",     null: false
    t.index ["pet_list_id", "user_id"], name: "index_pet_lists_users_on_pet_list_id_and_user_id", using: :btree
  end

  create_table "pets", force: :cascade do |t|
    t.integer  "api_id"
    t.boolean  "fav"
    t.integer  "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "pet_lists_pets", "pet_lists"
  add_foreign_key "pet_lists_pets", "pets"
end
