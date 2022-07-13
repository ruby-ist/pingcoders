class CreateTableLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.belongs_to :user
      t.belongs_to :repo
      t.timestamps
    end
  end
end
