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

ActiveRecord::Schema.define(version: 20151226061600) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bosses", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "salary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clerks", id: :serial, force: :cascade do |t|
    t.integer "boss_id"
    t.string "name"
    t.string "email"
    t.integer "salary"
    t.boolean "subject_to_lay_off"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image"
  end

  create_table "departments", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "department_id"
    t.string "email"
    t.date "birthdate"
    t.integer "salary"
    t.boolean "remote"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_employees_on_department_id"
  end

  create_table "file_records", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "size", default: 0
    t.boolean "leaf", default: false
    t.integer "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "expanded", default: false
    t.index ["lft"], name: "index_file_records_on_lft"
    t.index ["parent_id"], name: "index_file_records_on_parent_id"
    t.index ["rgt"], name: "index_file_records_on_rgt"
  end

  create_table "sessions", id: :serial, force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["session_id"], name: "index_sessions_on_session_id"
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  add_foreign_key "employees", "departments"
end
