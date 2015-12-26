class Clerk < ActiveRecord::Base
  default_scope { order(:id) }

  belongs_to :boss

  validates_presence_of :name

  mount_uploader :image, ImageUploader
end
