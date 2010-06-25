# Declare and configure attributes specifically for GridPanel
module Netzke::ModelExtensions
  class ClerkForGridPanel < Clerk
    # Virtual attribute defined in the model
    netzke_attribute :name, :renderer => "uppercase", :width => 200
    
    # Virtual attribute defined below (thus only to be shown in GridPanels)
    netzke_attribute :updated_bulb, :width => 40, :label => "<div class='bulb-off' />", :tooltip => "Recently updated"
    
    # Preconfigure a "real" attribute
    netzke_attribute :salary, :renderer => "usMoney"
    
    # Set the scopes for bosses listed in the association column
    netzke_attribute :boss__last_name, :editor => {:xtype => :combobox, :scopes => [["salary_greater_than", 95000]]}
    
    # Specify which columns and in which order to show
    netzke_expose_attributes :id, :name, :first_name, :last_name, :updated_bulb, :email, :salary, :boss__last_name      
    
    def updated_bulb
      bulb = updated ? "on" : "off"
      "<div class='bulb-#{bulb}' />"
    end
  end
end
