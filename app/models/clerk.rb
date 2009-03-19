class Clerk < ActiveRecord::Base
  # declare your association
  belongs_to :boss

  virtual_column :name
  def name
    "#{last_name}, #{first_name}"
  end

  # visually mark recently updated records
  virtual_column :updated
  def updated
    bulb = updated_at < 1.hour.ago ? "off" : "on"
    "<div class='bulb-#{bulb}' />"
  end

  # Which columns and in which order to expose.
  # Note the double underscore notation for signaling which column (or instance method) 
  # of the association should be used.
  expose_columns :id, # id should always be exposed and is by default hidden
    {:name => :name, :read_only => true, :sortable => false},
    {:name => :updated, :read_only => true, :width => 50, :sortable => false},
    :email, 
    {:name => :salary, :renderer => 'usMoney'},
    :boss__last_name # association
end
