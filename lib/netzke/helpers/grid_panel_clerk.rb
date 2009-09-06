module Netzke::Helpers::GridPanelClerk
  # which model's methods should be used as virtual column, along with configuration
  def self.virtual_attributes
    [:name]
  end
  
  # preconfigure some columns
  def self.attributes_config
    {
      :salary => {:renderer => "usMoney"},
      :updated_bulb => {:width => 30, :header => "<div class='bulb-off' />"},
      :name => {:renderer => "uppercase", :width => 200}
    }
  end
  
  # Which columns and in which order to expose.
  # Note the double underscore notation for signaling which (virtual) column
  # of the association should be used.
  def self.exposed_attributes
    %w{ id name first_name last_name updated_bulb email salary boss__last_name subject_to_lay_off }
  end
end