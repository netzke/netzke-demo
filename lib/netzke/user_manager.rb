module Netzke
  class UserManager < TableEditor
    # def self.js_base_class
    #   TableEditor
    # end
    def initialize(*args)
      super
      config[:grid_config]    = {:columns => [:id, :login, :login_count, :last_login_at, :last_request_at]}
      # config[:form_config]     = {:fields => [{:name => :id, :hidden => true}, :login, {:name => :password, :inputType => 'password'}, {:name => :password_confirmation, :inputType => 'password'}]}

      config[:split_region]    = :east
      config[:split_size]      = 400
      config[:data_class_name] = 'User'
    end
  end
end