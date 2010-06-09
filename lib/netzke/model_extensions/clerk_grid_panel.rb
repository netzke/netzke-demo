module Netzke::ModelExtensions
  # Declare and configure atttributes specifically for model Clerk and GridPanel
  module ClerkGridPanel
    def updated_bulb
      bulb = updated ? "on" : "off"
      "<div class='bulb-#{bulb}' />"
    end
    
    def self.included(klass)
      # Inject and configure netzke attributes into the model
      klass.netzke_attribute :updated_bulb, :read_only => true
      klass.netzke_attribute :name, :read_only => true
      klass.netzke_attribute :salary, :renderer => "usMoney"
      klass.netzke_attribute :updated_bulb, :width => 40, :label => "<div class='bulb-off'>"
      klass.netzke_attribute :name, :renderer => "uppercase", :width => 200
      
      # Specify which columns and in which order we want to see
      klass.netzke_expose_attributes :id, :name, :first_name, :last_name, :updated_bulb, :email, :salary, :boss__last_name      
    end
  end
end
