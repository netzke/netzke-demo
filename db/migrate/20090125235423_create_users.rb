class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :login,                 :null => false
      t.integer   :role_id,               :null => false
      t.string    :crypted_password,      :null => false
      t.string    :password_salt,         :null => false
      t.string    :persistence_token,     :null => false
      t.string    :single_access_token,   :null => false
      t.string    :perishable_token,      :null => false
      
      # magic columns
      t.integer   :login_count,           :null => false, :default => 0
      t.datetime :last_request_at
      t.datetime :last_login_at
      t.datetime :current_login_at
      t.string :last_login_ip
      t.string :current_login_ip
      
      t.timestamps
    end
    
    User.create(:login => 'admin', :password => 'admin', :password_confirmation => 'admin', :role_id => 1)
  end

  def self.down
    drop_table :users
  end
end
