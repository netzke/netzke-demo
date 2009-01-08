# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090106231709) do

  create_table "bosses", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "salary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clerks", :force => true do |t|
    t.string   "boss_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "salary"
    t.boolean  "subject_to_lay_off"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "netzke_grid_panel_columns", :force => true do |t|
    t.string   "name"
    t.string   "label"
    t.boolean  "read_only"
    t.integer  "position"
    t.boolean  "hidden"
    t.integer  "width"
    t.string   "editor",     :limit => 32
    t.integer  "layout_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "netzke_layouts", :force => true do |t|
    t.string   "widget_name"
    t.string   "items_class"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "netzke_preferences", :force => true do |t|
    t.string   "name"
    t.string   "pref_type"
    t.string   "value"
    t.integer  "user_id"
    t.integer  "role_id"
    t.string   "widget_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
