class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :image_url, :string
    add_column :users, :portfolio_url, :string
    add_column :users, :hackerrank_username, :string
    add_column :users, :stackoverflow_url, :string
    add_column :users, :linkedin_url, :string
  end
end
