class Boss < ActiveRecord::Base
  # Which columns and in which order to expose.
  # Note the double underscore notation for signaling which column (or instance method) 
  # of the association should be used.
  expose_columns :id, # id should always be exposed and is by default hidden
    :first_name,
    :last_name,
    :email,
    {:name => :salary, :renderer => 'usMoney'},
    :created_at,
    :updated_at
end
