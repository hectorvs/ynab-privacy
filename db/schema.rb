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

ActiveRecord::Schema.define(version: 2018_08_18_192301) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "category_card_links", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "user_id"
    t.string "account_id"
    t.string "account_name"
    t.string "budget_id"
    t.string "budget_name"
    t.string "category_id"
    t.string "category_name"
    t.string "privacy_card_id"
    t.string "privacy_card_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["privacy_card_id"], name: "index_category_card_links_on_privacy_card_id", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "provider"
    t.string "privacy_key"
    t.string "ynab_access_token"
    t.string "ynab_refresh_token"
    t.string "ynab_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
