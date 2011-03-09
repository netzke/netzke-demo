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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110306181243) do

  create_table "bosses", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "salary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clerks", :force => true do |t|
    t.integer  "boss_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "salary"
    t.boolean  "subject_to_lay_off"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image"
  end

  create_table "netzke_component_states", :force => true do |t|
    t.string   "component"
    t.integer  "user_id"
    t.integer  "role_id"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "netzke_component_states", ["component"], :name => "index_netzke_component_states_on_component"
  add_index "netzke_component_states", ["role_id"], :name => "index_netzke_component_states_on_role_id"
  add_index "netzke_component_states", ["user_id"], :name => "index_netzke_component_states_on_user_id"

  create_table "netzke_preferences", :force => true do |t|
    t.string   "key"
    t.text     "value"
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "netzke_temp_table", :force => true do |t|
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end
