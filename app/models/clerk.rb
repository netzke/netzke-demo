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
    img = updated_at < 1.hour.ago ? "lightbulb_off" : "lightbulb"
    "<img src='/images/icons/#{img}.png' />"
  end

  # Which columns and in which order to expose.
  # Note the double underscore notation for signaling which column (or instance method) 
  # of the association should be used.
  expose_columns :id, # id should always be exposed and is by default hidden
    {:name => :name, :read_only => true},
    {:name => :updated, :read_only => true, :width => 50},
    :email, 
    :salary,
    {:name => :boss__last_name, :read_only => true}
end
