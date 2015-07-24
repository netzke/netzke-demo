class AddExpandedToFileRecords < ActiveRecord::Migration
  def change
    add_column :file_records, :expanded, :boolean, default: false
  end
end
