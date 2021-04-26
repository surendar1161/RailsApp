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

ActiveRecord::Schema.define(version: 2021_04_06_093002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "monday_account_id"
    t.datetime "created_at"
    t.integer "account_status"
    t.integer "locations", default: [], array: true
    t.integer "plan_type"
  end

  create_table "categories", force: :cascade do |t|
    t.integer "account_id"
    t.string "category_name"
    t.string "category_display_name"
    t.datetime "created_at"
    t.integer "locations", default: [], array: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.text "address"
    t.integer "account_id"
    t.string "phone"
    t.integer "no_of_orders"
  end

  create_table "delivery_agencies", force: :cascade do |t|
    t.string "agency_name"
    t.integer "account_id"
    t.string "address"
    t.string "phone"
    t.integer "location"
    t.boolean "is_active"
    t.integer "rating"
    t.datetime "created_at"
  end

  create_table "deliveryagents", force: :cascade do |t|
    t.integer "agency_id"
    t.string "agent_name"
    t.string "phone"
    t.boolean "is_active"
    t.integer "total_orders", default: 0
    t.integer "rating"
    t.datetime "created_at"
  end

  create_table "locations", force: :cascade do |t|
    t.string "location_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_product_mappings", force: :cascade do |t|
    t.string "order_id"
    t.integer "category_id"
    t.integer "product_id"
    t.float "price"
    t.integer "quantity"
    t.datetime "created_at"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "account_id"
    t.string "order_id"
    t.float "total_price"
    t.integer "status"
    t.integer "delivery_person_id"
    t.integer "customer_id"
    t.boolean "invoice_generated"
    t.string "payment_done"
    t.datetime "order_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.integer "category_id"
    t.integer "location_id"
    t.float "price"
    t.integer "quantity"
    t.string "name"
    t.integer "supplier_id", default: [], array: true
  end

  create_table "stock_entries", force: :cascade do |t|
    t.string "stock_id"
    t.integer "payment_status"
    t.integer "total_price"
    t.integer "account_id"
    t.integer "vendor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendor_product_mappings", force: :cascade do |t|
    t.integer "product_id"
    t.integer "category_id"
    t.integer "location"
    t.integer "quantity"
    t.integer "price"
    t.string "stock_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.text "address"
    t.integer "account_id"
    t.integer "rating"
    t.datetime "created_at"
  end

end
