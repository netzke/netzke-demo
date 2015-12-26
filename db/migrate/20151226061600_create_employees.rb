class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.references :department, index: true, foreign_key: true
      t.string :email
      t.date :birthdate
      t.integer :salary
      t.boolean :remote

      t.timestamps null: false
    end
  end
end
