# encoding: UTF-8
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

  create_table "bosses", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "salary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clerks", force: :cascade do |t|
    t.integer  "boss_id"
    t.string   "name"
    t.string   "email"
    t.integer  "salary"
    t.boolean  "subject_to_lay_off"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.string   "logo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.integer  "department_id"
    t.string   "email"
    t.date     "birthdate"
    t.integer  "salary"
    t.boolean  "remote"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "employees", ["department_id"], name: "index_employees_on_department_id", using: :btree

  create_table "file_records", force: :cascade do |t|
    t.string   "name"
    t.integer  "size",       default: 0
    t.boolean  "leaf",       default: false
    t.integer  "parent_id"
    t.integer  "lft",                        null: false
    t.integer  "rgt",                        null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "expanded",   default: false
  end

  add_index "file_records", ["lft"], name: "index_file_records_on_lft", using: :btree
  add_index "file_records", ["parent_id"], name: "index_file_records_on_parent_id", using: :btree
  add_index "file_records", ["rgt"], name: "index_file_records_on_rgt", using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  add_foreign_key "employees", "departments"
end
