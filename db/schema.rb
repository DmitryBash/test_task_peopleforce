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

ActiveRecord::Schema[7.1].define(version: 2024_01_10_172819) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dynabute_options", force: :cascade do |t|
    t.integer "field_id"
    t.string "label"
    t.index ["field_id"], name: "index_dynabute_options_on_field_id"
  end

  create_table "dynabute_select_values", force: :cascade do |t|
    t.integer "field_id"
    t.integer "dynabutable_id"
    t.string "dynabutable_type", limit: 50
    t.integer "value"
    t.index ["dynabutable_id", "field_id"], name: "dynabute_select_values_on_record_id_and_recordable_id"
    t.index ["dynabutable_id"], name: "dynabute_select_values_on_recordable_id"
  end

  create_table "dynamic_fields", force: :cascade do |t|
    t.string "name", null: false
    t.string "value_type"
    t.boolean "multiple", default: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "user_id, lower((name)::text)", name: "index_dynamic_fields_on_user_id_lower_name", unique: true
    t.index ["user_id"], name: "index_dynamic_fields_on_user_id"
  end

  create_table "dynamic_values", force: :cascade do |t|
    t.string "string_value"
    t.integer "number_value"
    t.integer "select_value"
    t.bigint "dynamic_field_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dynamic_field_id"], name: "index_dynamic_values_on_dynamic_field_id"
  end

  create_table "options", force: :cascade do |t|
    t.bigint "dynamic_field_id"
    t.string "label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dynamic_field_id"], name: "index_options_on_dynamic_field_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
