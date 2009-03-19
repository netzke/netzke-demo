module Netzke
  class UserManager < TableEditor
    def self.js_base_class
      TableEditor
    end
    def initialize(*args)
      super
      
      config[:grid_config]    = {
        :columns => [
          :id, 
          :login, 
          :login_count, 
          :last_login_at, 
          :last_request_at],
        :prohibit => :delete
      }
      
      config[:form_config]    = {
        :fields => [
          :id, 
          :login, 
          {:name => :login_count, :disabled => true}, 
          {:name => :password, :inputType => 'password'}, 
          {:name => :password_confirmation, :inputType => 'password'}, 
          {:name => :last_request_at, :disabled => true}, 
          {:name => :current_login_at, :disabled => true}, 
          {:name => :last_login_ip, :disabled => true}, 
          {:name => :current_login_ip, :disabled => true}, 
          {:name => :created_at, :disabled => true},
          {:name => :updated_at, :disabled => true}
        ]
      }

      config[:split_region]    = :east
      config[:split_size]      = 400
      config[:data_class_name] = 'User'
    end
  end
end