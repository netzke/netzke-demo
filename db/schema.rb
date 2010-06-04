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

ActiveRecord::Schema.define(:version => 20100602212620) do

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

  create_table "netzke_auto_columns", :force => true do |t|
    t.string  "name"
    t.boolean "excluded"
    t.string  "value"
    t.string  "header"
    t.boolean "hidden"
    t.boolean "editable",     :default => true
    t.string  "editor"
    t.string  "renderer"
    t.boolean "with_filters", :default => true
    t.integer "width"
    t.boolean "hideable",     :default => true
    t.boolean "sortable",     :default => true
    t.integer "position"
  end

  create_table "netzke_auto_fields", :force => true do |t|
    t.boolean "hidden"
    t.string  "name"
    t.string  "condition"
    t.string  "field_label"
    t.string  "xtype"
    t.string  "value"
    t.integer "position"
  end

  create_table "netzke_field_lists", :force => true do |t|
    t.string   "name"
    t.text     "value"
    t.string   "model_name"
    t.integer  "user_id"
    t.integer  "role_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "netzke_preferences", :force => true do |t|
    t.string   "name"
    t.string   "pref_type"
    t.text     "value"
    t.integer  "user_id"
    t.integer  "role_id"
    t.string   "widget_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "netzke_temp_table", :force => true do |t|
    t.integer "position"
    t.string  "attr_type"
    t.boolean "hidden"
    t.string  "name"
    t.string  "field_label"
    t.string  "xtype"
    t.string  "value"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "login",                              :null => false
    t.integer  "role_id",                            :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.datetime "current_login_at"
    t.string   "last_login_ip"
    t.string   "current_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
