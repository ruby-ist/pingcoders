module NotificationsHelpers

	def create(kind)
		notification = Notification.create!(user: current_user)
		case kind
		when 0 then notification.request!
		when 1 then notification.repo!
		when 2 then notification.job!
		end

		sent_notification(notification)
	end

	def sent_notification(notification)
		user = notification.user
		followers = Connection.select('sent_id AS user_id').where(received_id: user.id)
		followers += Connection.select('received_id AS user_id').where(sent_id: user.id)
		followers.each do |f|
			UserAlert.create!(user_id: f.user_id, notification_id: notification.id)
		end
	end

end
