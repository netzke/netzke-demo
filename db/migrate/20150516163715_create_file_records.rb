class CreateFileRecords < ActiveRecord::Migration
  def change
    create_table :file_records do |t|
      t.string :name
      t.integer :size, default: 0
      t.boolean :leaf, default: false
      t.boolean :expanded, default: false
      t.references :parent, index: true, null: true
      t.integer :lft, index: true, null: false
      t.integer :rgt, index: true, null: false

      t.timestamps null: false
    end
  end
end
