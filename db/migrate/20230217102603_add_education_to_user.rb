class AddEducationToUser < ActiveRecord::Migration[7.0]
  def change
    create_table :educations do |t|
      t.string :institute
      t.integer :passed_year
      t.string :degree
      t.float :percentage
      t.belongs_to :user

      t.timestamps
    end
  end
end
