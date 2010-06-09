module Netzke::ModelExtensions
  module UserGridPanel
    module InstanceMethods
      def active_recently
        bulb = active_recently? ? "on" : "off"
        "<div class='bulb-#{bulb}' />"
      end
    end
    
    def self.included(receiver)
      receiver.netzke_attribute :active_recently
      receiver.netzke_attribute :password, :editor => {:xtype => :textfield, :input_type => :password}
      receiver.netzke_attribute :password_confirmation, :editor => {:xtype => :textfield, :input_type => :password}
      receiver.send :include, InstanceMethods
    end
  end
end