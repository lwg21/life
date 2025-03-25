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

ActiveRecord::Schema[8.0].define(version: 2025_03_25_113702) do
  create_table "achievements", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_achievements_on_code", unique: true
  end

  create_table "goals", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_goals_on_code", unique: true
  end

  create_table "habit_logs", force: :cascade do |t|
    t.integer "habit_id", null: false
    t.date "log_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_habit_logs_on_habit_id"
  end

  create_table "habits", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_habits_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "unlocks", force: :cascade do |t|
    t.integer "achievement_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_id"], name: "index_unlocks_on_achievement_id"
    t.index ["user_id", "achievement_id"], name: "index_unlocks_on_user_id_and_achievement_id", unique: true
    t.index ["user_id"], name: "index_unlocks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "habit_logs", "habits"
  add_foreign_key "habits", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "unlocks", "achievements"
  add_foreign_key "unlocks", "users"
end
