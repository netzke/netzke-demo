module Netzke::ModelExtensions
  class UserForGridPanel < User
    netzke_attribute :password, :editor => {:xtype => :textfield, :input_type => :password}
    netzke_attribute :password_confirmation, :editor => {:xtype => :textfield, :input_type => :password}
    
    netzke_attribute :active_recently
    def active_recently
      bulb = active_recently? ? "on" : "off"
      "<div class='bulb-#{bulb}' />"
    end
  end
end