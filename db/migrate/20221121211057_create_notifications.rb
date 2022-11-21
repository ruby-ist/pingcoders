class CreateNotifications < ActiveRecord::Migration[7.0]
	def change
		create_table :notifications do |t|
			t.integer :kind, default: 0
			t.belongs_to :user

			t.timestamps
		end

		create_table :user_alerts do |t|
			t.belongs_to :user
			t.belongs_to :notification

			t.timestamps
		end
	end
end
