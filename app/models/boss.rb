class Boss < ActiveRecord::Base
  # Which columns and in which order to expose.
  # Note the double underscore notation for signaling which column (or instance method) 
  # of the association should be used.
  
  validates_presence_of :last_name

  def name
    "#{last_name}, #{first_name}"
  end

  # because it's a virtual column, we need to implement the search method ourselves
  def self.find_by_name(name)
    all = self.find(:all)
    all.detect{|r| r.name == name}
  end
  
end
