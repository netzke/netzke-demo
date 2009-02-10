class User < ActiveRecord::Base
  acts_as_authentic
  virtual_column :password => {:inputType => 'password'}
  virtual_column :password_confirmation => {:inputType => 'password'}
end
