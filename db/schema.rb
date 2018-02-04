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

ActiveRecord::Schema.define(version: 20180204223940) do

  create_table "sources", force: :cascade do |t|
    t.string "title", null: false
    t.string "link"
    t.string "description"
    t.string "language", null: false
    t.string "copyright"
    t.string "managingEditor"
    t.string "webMaster"
    t.datetime "pubDate"
    t.datetime "lastBuildDate"
    t.string "category"
    t.string "generator"
    t.string "docs"
    t.string "cloud"
    t.integer "ttl"
    t.string "image"
    t.string "rating"
    t.string "textInput"
    t.integer "skipHours"
    t.integer "skipDays"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rss_uri", null: false
    t.index ["rss_uri"], name: "index_sources_on_rss_uri"
  end

end
