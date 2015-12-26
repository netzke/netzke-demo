class Clerk < ActiveRecord::Base
  default_scope { order(:id) }

  belongs_to :boss

  validates_presence_of :name

  mount_uploader :image, ImageUploader

  # this method will be used by another "virtual column"
  def updated
    self.updated_at > 5.minutes.ago
  end
end
