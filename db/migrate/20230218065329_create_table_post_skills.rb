class CreateTablePostSkills < ActiveRecord::Migration[7.0]
  def change
    create_table :post_skills do |t|
      t.belongs_to :post
      t.belongs_to :skill

      t.timestamps
    end
  end
end
