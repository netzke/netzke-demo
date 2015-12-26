class Boss < ActiveRecord::Base
  default_scope { order(:id) }

  has_many :clerks

  validates_presence_of :last_name
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def name
    "#{last_name}, #{first_name}"
  end

  # because it's a virtual column, we need to implement the search method ourselves
  def self.find_by_name(name)
    all = self.find(:all)
    all.detect{|r| r.name == name}
  end

  def clerks_number
    clerks.count
  end
end
