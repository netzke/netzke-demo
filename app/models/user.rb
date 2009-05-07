class User < ActiveRecord::Base
  belongs_to :role
  acts_as_authentic
  virtual_column :password #=> {:inputType => 'password'}
  virtual_column :password_confirmation #=> {:inputType => 'password'}
end
