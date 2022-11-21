class ConnectionsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_connection, only: [:update, :destroy]

	def create
		Connection.create!(sent_id: current_user.id, received_id: params[:profile_id])
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
		@connection = Connection.where(sent_id: params[:profile_id], received_id: current_user.id)
							   .or(Connection.where(sent_id: current_user.id, received_id: params[:profile_id])).first
	end
end
