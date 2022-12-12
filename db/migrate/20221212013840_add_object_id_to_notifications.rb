class AddObjectIdToNotifications < ActiveRecord::Migration[7.0]
	def change
		add_column :notifications, :object_id, :integer
	end
end
