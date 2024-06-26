# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_05_104231) do
  create_table "buffets", force: :cascade do |t|
    t.integer "owner_id", null: false
    t.string "brand_name"
    t.string "corporate_name"
    t.string "register_number"
    t.string "phone_number"
    t.string "address"
    t.string "district"
    t.string "state"
    t.string "city"
    t.string "zip_code"
    t.text "description"
    t.string "payment_methods"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_buffets_on_owner_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "register_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "min_quantity_people"
    t.integer "max_quantity_people"
    t.integer "duration_in_minutes"
    t.text "menu"
    t.boolean "alcoholic_drink"
    t.boolean "self_decoration"
    t.boolean "parking"
    t.boolean "valet"
    t.boolean "fixed_location"
    t.integer "owner_id", null: false
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_events_on_buffet_id"
    t.index ["owner_id"], name: "index_events_on_owner_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "buffet_id", null: false
    t.integer "event_id", null: false
    t.date "estimated_date"
    t.integer "estimated_people"
    t.text "details"
    t.string "code"
    t.string "address"
    t.integer "status", default: 0
    t.integer "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_orders_on_buffet_id"
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["event_id"], name: "index_orders_on_event_id"
  end

  create_table "owners", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_owners_on_email", unique: true
    t.index ["reset_password_token"], name: "index_owners_on_reset_password_token", unique: true
  end

  create_table "price_events", force: :cascade do |t|
    t.integer "min_price_working_day"
    t.integer "additional_price_for_person_working_day"
    t.integer "extra_hour_working_day"
    t.integer "min_price_weekend"
    t.integer "additional_price_for_person_weekend"
    t.integer "extra_hour_weekend"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "event_id", null: false
    t.index ["event_id"], name: "index_price_events_on_event_id"
  end

  create_table "price_orders", force: :cascade do |t|
    t.integer "initial_price"
    t.integer "rate"
    t.text "description_rate"
    t.integer "final_price"
    t.string "payment_methods"
    t.date "deadline"
    t.integer "owner_id", null: false
    t.integer "order_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_price_orders_on_order_id"
    t.index ["owner_id"], name: "index_price_orders_on_owner_id"
  end

  add_foreign_key "buffets", "owners"
  add_foreign_key "events", "buffets"
  add_foreign_key "events", "owners"
  add_foreign_key "orders", "buffets"
  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "events"
  add_foreign_key "price_events", "events"
  add_foreign_key "price_orders", "orders"
  add_foreign_key "price_orders", "owners"
end
