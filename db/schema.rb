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

ActiveRecord::Schema[7.0].define(version: 2023_04_14_204147) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id"
    t.string "username"
    t.string "password"
    t.string "token"
    t.integer "user_level"
    t.boolean "is_active"
  end

  create_table "logins", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "login_time"
    t.datetime "logout_time"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "qty", default: 0
    t.float "price", default: 0.0
    t.float "amount", default: 0.0
    t.string "kind"
    t.string "stock_code", default: ""
    t.string "crypto_code", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "fname"
    t.string "mname"
    t.string "lname"
    t.string "contacts"
    t.string "address"
    t.float "balance", default: 0.0
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
