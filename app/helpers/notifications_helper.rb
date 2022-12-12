module NotificationsHelper

	def create_notification(kind, object_id)
		notification = Notification.create!(user: current_user, object_id: object_id)
		case kind
		when :request then notification.request!
		when :repo then notification.repo!
		when :job then notification.job!
		end

		if kind != :request
			sent_notification(notification)
		else
			notification
		end
	end

	def sent_notification(notification)
		user = notification.user
		followers = Connection.select('sent_id AS user_id').where(received_id: user.id, status: :accepted)
		followers += Connection.select('received_id AS user_id').where(sent_id: user.id, status: :accepted)
		followers.each do |f|
			UserAlert.create!(user_id: f.user_id, notification_id: notification.id)
		end
	end

end
