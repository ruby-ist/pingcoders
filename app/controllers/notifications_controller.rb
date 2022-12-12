class NotificationsController < ApplicationController

	before_action :authenticate_user!

	def update
		notification = Notification.find params[:id]
		if notification.request?
			connection = Connection.find notification.object_id
			connection.accepted!
			notification.accepted!
		elsif notification.accepted?
			connection = Connection.find notification.object_id
			connection.requested!
			notification.request!
		end
		redirect_to profile_path current_user.id
	end

end
