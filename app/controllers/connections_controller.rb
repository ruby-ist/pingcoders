class ConnectionsController < ApplicationController

	include NotificationsHelper

	before_action :authenticate_user!
	before_action :set_connection, only: [:update, :destroy]

	def index
		@user = User.find params[:profile_id]
		@users = Connection.select('received_id AS user_id').where(sent_id: params[:profile_id], status: :accepted)
		@users += Connection.select('sent_id AS user_id').where(received_id: params[:profile_id], status: :accepted)
		@users.map! { |u| User.find(u.user_id) }
	end

	def create
		Connection.create!(sent_id: current_user.id, received_id: params[:profile_id])
		notification = create_notification :request
		UserAlert.create!(user_id: params[:profile_id], notification: notification.id)
		redirect_to profile_path(params[:profile_id])
	end

	def update
		if @connection
			@connection.accepted!
		end
		redirect_to profile_path(params[:profile_id])
	end

	def destroy
		@connection.destroy
		redirect_to profile_path(params[:profile_id])
	end

	private

	def set_connection
		@connection = Connection.find_by(sent_id: params[:profile_id], received_id: current_user.id) || Connection.find_by(sent_id: current_user.id, received_id: params[:profile_id])
	end
end
