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

ActiveRecord::Schema.define(version: 20150718093145) do

  create_table "histories", force: :cascade do |t|
    t.integer  "movie_id",   limit: 4
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "histories_products", id: false, force: :cascade do |t|
    t.integer "history_id", limit: 4, null: false
    t.integer "product_id", limit: 4, null: false
  end

  add_index "histories_products", ["history_id"], name: "index_histories_products_on_history_id", using: :btree
  add_index "histories_products", ["product_id"], name: "index_histories_products_on_product_id", using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "movie_id",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.integer  "shop_id",               limit: 4
    t.string   "product_id",            limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "product_name",          limit: 255
    t.string   "product_image_url",     limit: 255
    t.string   "maker",                 limit: 255
    t.integer  "buy_num",               limit: 4
    t.integer  "clicked_num",           limit: 4
    t.integer  "clicked_at_this_movie", limit: 4
  end

  add_index "products", ["product_id"], name: "index_products_on_product_id", unique: true, using: :btree

end
