class User < ActiveRecord::Base
  belongs_to :role
  acts_as_authentic

  def active_recently?
    last_request_at && last_request_at > 1.day.ago
  end
end
