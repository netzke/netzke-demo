class CreateClerks < ActiveRecord::Migration
  def self.up
    create_table :clerks do |t|
      t.integer :boss_id
      t.string :name
      t.string :email
      t.integer :salary
      t.boolean :subject_to_lay_off

      t.timestamps
    end
  end

  def self.down
    drop_table :clerks
  end
end
