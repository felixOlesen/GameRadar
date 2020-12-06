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

ActiveRecord::Schema.define(version: 2020_12_06_112055) do

  create_table "forums", force: :cascade do |t|
    t.integer "game_id", null: false
    t.string "title", null: false
    t.text "entry", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_forums_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name", null: false
    t.text "deck"
    t.datetime "og_release_date"
    t.integer "expected_release_day"
    t.integer "expected_release_month"
    t.integer "expected_release_year"
    t.string "platforms"
    t.string "image"
    t.integer "gb_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gb_id"], name: "index_games_on_gb_id", unique: true
  end

end
