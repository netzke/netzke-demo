module Netzke
  class UserManager < TableEditor

    #
    # By specifying TableEditor as js_base_class, we enable Javascript-level inheritance
    #
    def self.js_base_class
      TableEditor
    end

    def initialize(*args)
      super
      
      #
      # Default columns and fields
      #
      config[:grid_config]    = {
        :columns => [
          :id, 
          :login,
          :role__name,
          :login_count, 
          :last_login_at, 
          :last_request_at]
      }
      
      config[:form_config]    = {
        :fields => [
          :id, 
          :login,
          :role__name,
          {:name => :password, :xtype => 'passfield'}, 
          {:name => :password_confirmation, :xtype => 'passfield'}, 
          {:name => :login_count, :disabled => true}, 
          {:name => :last_request_at, :disabled => true}, 
          {:name => :current_login_at, :disabled => true}, 
          {:name => :last_login_ip, :disabled => true}, 
          {:name => :current_login_ip, :disabled => true}, 
          {:name => :created_at, :disabled => true},
          {:name => :updated_at, :disabled => true}
        ]
      }

      #
      # Default configs
      #
      config[:split_region]    ||= :east
      config[:split_size]      ||= 400
      config[:data_class_name] ||= 'User'
    end
  end
end