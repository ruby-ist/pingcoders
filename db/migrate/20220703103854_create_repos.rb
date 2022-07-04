class CreateRepos < ActiveRecord::Migration[7.0]
  def change
    create_table :repos do |t|
      t.string :name
      t.belongs_to :user

      t.timestamps
    end

    add_column :users ,:github_username, :string
  end
end
