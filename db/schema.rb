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

ActiveRecord::Schema.define(version: 2021_08_10_154348) do

  create_table "arduino_healthy_checks", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_arduino_healthy_checks_on_user_id"
  end

  create_table "attachments", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "attachable_type", null: false
    t.bigint "attachable_id", null: false
    t.string "file"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attachable_type", "attachable_id"], name: "index_attachments_on_attachable"
  end

  create_table "clients", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "full_name", null: false
    t.string "domain"
    t.string "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "iso", null: false
    t.string "name", null: false
    t.string "nicename", null: false
    t.string "iso3"
    t.string "numcode"
    t.string "phonecode", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "plantcares", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.float "wet"
    t.date "planted_at"
    t.string "status"
    t.datetime "watered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "main_picture"
    t.index ["main_picture"], name: "index_plantcares_on_main_picture"
    t.index ["user_id"], name: "index_plantcares_on_user_id"
  end

  create_table "roles", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "user_tokens", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.integer "user_id"
    t.date "expired_at"
    t.boolean "expired", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "wtever_token"
    t.index ["user_id"], name: "fk_rails_e0a9c15abb"
  end

  create_table "users", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "country_code"
    t.string "timezone"
    t.string "lang"
    t.string "profile_picture"
    t.string "encrypted_password"
    t.string "salt"
    t.date "deleted_at"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "users_roles", id: false, charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "water_pumps", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "field"
    t.integer "plantcare_id"
    t.index ["field"], name: "index_water_pumps_on_field"
    t.index ["plantcare_id"], name: "index_water_pumps_on_plantcare_id"
  end

  create_table "watering_schedules", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.datetime "starts_on"
    t.datetime "ends_on"
    t.string "status"
    t.integer "plantcare_id", null: false
    t.string "duration_unit"
    t.integer "duration_amount"
    t.string "frequency_unit"
    t.integer "frequency_amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["plantcare_id"], name: "index_watering_schedules_on_plantcare_id"
  end

  create_table "waterings", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.integer "water_pump_id", null: false
    t.string "duration_unit", null: false
    t.integer "duration_amount", null: false
    t.string "status", null: false
    t.datetime "programmed_at", null: false
    t.datetime "consumed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "watering_schedule_id"
    t.index ["water_pump_id"], name: "index_waterings_on_water_pump_id"
    t.index ["watering_schedule_id"], name: "fk_rails_6154b79906"
  end

  create_table "wet_sensors", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "field"
    t.string "status"
    t.integer "plantcare_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["field"], name: "index_wet_sensors_on_field"
    t.index ["plantcare_id"], name: "index_wet_sensors_on_plantcare_id"
  end

  create_table "wet_statuses", id: :integer, charset: "utf8mb4", force: :cascade do |t|
    t.float "wet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "wet_sensor_id"
    t.index ["wet_sensor_id"], name: "index_wet_statuses_on_wet_sensor_id"
  end

  add_foreign_key "plantcares", "users"
  add_foreign_key "user_tokens", "users"
  add_foreign_key "water_pumps", "plantcares"
  add_foreign_key "watering_schedules", "plantcares"
  add_foreign_key "waterings", "water_pumps"
  add_foreign_key "waterings", "watering_schedules"
  add_foreign_key "wet_sensors", "plantcares"
  add_foreign_key "wet_statuses", "wet_sensors"
end
