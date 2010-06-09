module Netzke::ModelExtensions
  module UserFormPanel
    def self.included(receiver)
      receiver.netzke_attribute :password, :editor => {:xtype => :textfield, :input_type => :password}
      receiver.netzke_attribute :password_confirmation, :editor => {:xtype => :textfield, :input_type => :password}
      receiver.send :include, InstanceMethods
    end
  end
end