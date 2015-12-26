class Boss < ActiveRecord::Base
  default_scope { order(:id) }

  has_many :clerks

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def clerks_number
    clerks.count
  end
end
