class Employee < ActiveRecord::Base
  default_scope { order(:id) }
  belongs_to :department
end
