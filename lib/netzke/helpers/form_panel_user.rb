module Netzke::Helpers::FormPanelUser
  def self.virtual_attributes
    [:password, :password_confirmation]
  end
  
  def self.exposed_attributes
    [:id, :login, :role__name, :password, :password_confirmation]
  end
  
  def self.attributes_config
    pass_config = {:input_type => 'password'}
    {:password => pass_config, :password_confirmation => pass_config}
  end
end