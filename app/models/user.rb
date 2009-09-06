class User < ActiveRecord::Base
  belongs_to :role
  acts_as_authentic
  # netzke_virtual_attribute :password #=> {:inputType => 'password'}
  # netzke_virtual_attribute :password_confirmation #=> {:inputType => 'password'}
end
