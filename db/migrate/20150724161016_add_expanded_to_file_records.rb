class AddExpandedToFileRecords < ActiveRecord::Migration[4.2]
  def change
    add_column :file_records, :expanded, :boolean, default: false
  end
end
