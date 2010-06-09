module Netzke::ModelExtensions
  # Declare and configure atttributes specifically for model Clerk and GridPanel
  class ClerkForGridPanel < Clerk
    netzke_attribute :name, :read_only => true
    netzke_attribute :salary, :renderer => "usMoney"
    netzke_attribute :updated_bulb, :width => 40, :label => "<div class='bulb-off' />"
    netzke_attribute :name, :renderer => "uppercase", :width => 200
    
    # Specify which columns and in which order we want to see
    netzke_expose_attributes :id, :name, :first_name, :last_name, :updated_bulb, :email, :salary, :boss__last_name      
    
    netzke_attribute :updated_bulb
    def updated_bulb
      bulb = updated ? "on" : "off"
      "<div class='bulb-#{bulb}' />"
    end
  end
end
