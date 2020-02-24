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

ActiveRecord::Schema.define(version: 2020_02_24_231157) do

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ebooks", force: :cascade do |t|
    t.integer "category_id"
    t.string "title"
    t.string "author"
    t.text "description"
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_url"
    t.integer "stock"
    t.text "abstract"
    t.index ["category_id"], name: "index_ebooks_on_category_id"
  end

  create_table "order_ebooks", force: :cascade do |t|
    t.integer "order_id"
    t.integer "ebook_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ebook_id"], name: "index_order_ebooks_on_ebook_id"
    t.index ["order_id"], name: "index_order_ebooks_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "user_ebooks", force: :cascade do |t|
    t.integer "user_id"
    t.integer "ebook_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity", default: 0
    t.index ["ebook_id"], name: "index_user_ebooks_on_ebook_id"
    t.index ["user_id"], name: "index_user_ebooks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.boolean "admin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
