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

ActiveRecord::Schema.define(version: 20170913204327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "attachments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.bigint "order_id"
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.index ["order_id"], name: "index_attachments_on_order_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "min_quantity", default: 10
    t.bigint "category_id"
    t.index ["category_id"], name: "index_dishes_on_category_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "owner_id"
    t.string "owner_type"
    t.integer "quantity"
    t.integer "item_id"
    t.string "item_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "SEK", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "delivery_date"
    t.text "allergies"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "boxes"
    t.string "status"
    t.string "email"
    t.string "delivery_method"
    t.string "delivery_name"
    t.string "delivery_address"
    t.string "delivery_postal_code"
    t.string "delivery_city"
    t.string "delivery_floor"
    t.string "delivery_door_code"
    t.string "delivery_contact_name"
    t.string "delivery_contact_phone_number"
    t.string "billing_name"
    t.string "billing_company"
    t.string "billing_org_nr"
    t.string "billing_address"
    t.string "billing_postal_code"
    t.string "billing_city"
    t.string "billing_phone"
    t.string "billing_email"
  end

  add_foreign_key "attachments", "orders"
  add_foreign_key "dishes", "categories"
end
