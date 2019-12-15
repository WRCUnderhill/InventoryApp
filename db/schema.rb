# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_15_222614) do

  create_table "channels", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "channel_item_id"
    t.string "channel_inventory_id"
    t.string "price"
    t.integer "product_id", null: false
    t.integer "channel_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_items_on_channel_id"
    t.index ["product_id"], name: "index_items_on_product_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.string "channel_location_id"
    t.string "city"
    t.string "country"
    t.boolean "nonstocking"
    t.integer "channel_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_locations_on_channel_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "channel_product_id"
    t.string "label_1"
    t.string "label_2"
    t.string "label_3"
    t.integer "channel_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_products_on_channel_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "level"
    t.integer "item_id", null: false
    t.integer "location_id", null: false
    t.integer "product_id", null: false
    t.integer "channel_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["channel_id"], name: "index_stocks_on_channel_id"
    t.index ["item_id"], name: "index_stocks_on_item_id"
    t.index ["location_id"], name: "index_stocks_on_location_id"
    t.index ["product_id"], name: "index_stocks_on_product_id"
  end

  add_foreign_key "items", "channels"
  add_foreign_key "items", "products"
  add_foreign_key "locations", "channels"
  add_foreign_key "products", "channels"
  add_foreign_key "stocks", "channels"
  add_foreign_key "stocks", "items"
  add_foreign_key "stocks", "locations"
  add_foreign_key "stocks", "products"
end
