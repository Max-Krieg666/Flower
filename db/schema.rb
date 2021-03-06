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

ActiveRecord::Schema.define(version: 20161103233710) do

  create_table "kinds", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.integer  "quantity"
    t.decimal  "price",      precision: 15, scale: 2
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "pack_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id"
  add_index "line_items", ["pack_id"], name: "index_line_items_on_pack_id"
  add_index "line_items", ["product_id"], name: "index_line_items_on_product_id"

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "address"
    t.string   "fio"
    t.string   "phone"
    t.integer  "status",     default: 0
    t.text     "comment"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "packs", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price",              precision: 15, scale: 2
    t.integer  "color"
    t.text     "description"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.decimal  "price",              precision: 15, scale: 2
    t.integer  "color"
    t.integer  "kind_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "fio"
    t.string   "password_digest"
    t.string   "phone_number"
    t.text     "address"
    t.integer  "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
