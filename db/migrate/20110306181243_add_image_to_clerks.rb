class AddImageToClerks < ActiveRecord::Migration[4.2]
  def self.up
    add_column :clerks, :image, :string
  end

  def self.down
    remove_column :clerks, :image
  end
end
