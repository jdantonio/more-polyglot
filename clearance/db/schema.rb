# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150214162522) do

  create_table "clearance_batches", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "size"
    t.string   "color"
    t.string   "status"
    t.datetime "sold_at"
    t.integer  "style_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "clearance_batch_id"
    t.integer  "price_sold_cents"
  end

  add_index "items", ["clearance_batch_id"], name: "index_items_on_clearance_batch_id"

  create_table "styles", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "wholesale_price_cents"
    t.integer  "retail_price_cents"
    t.integer  "minimum_price_cents",   default: 200
  end

end
