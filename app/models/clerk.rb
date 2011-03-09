class Clerk < ActiveRecord::Base
  belongs_to :boss

  validates_presence_of :first_name
  validates_presence_of :last_name

  mount_uploader :image, ImageUploader

  # result of this method will be displayed in a "virtual column"
  def name
    "#{last_name}, #{first_name}"
  end

  # this method will be used by another "virtual column"
  def updated
    self.updated_at > 5.minutes.ago
  end

  netzke_attribute :name, :renderer => "uppercase", :width => 200

end
