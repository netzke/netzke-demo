module Netzke::ModelExtensions
  class UserForFormPanel < User
    netzke_attribute :password, :editor => {:xtype => :textfield, :input_type => :password}
    netzke_attribute :password_confirmation, :editor => {:xtype => :textfield, :input_type => :password}
  end
end