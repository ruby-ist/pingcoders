class MessagesController < ApplicationController

	before_action :authenticate_user!

	def create
		room = Room.find params[:room]
		user = current_user
		Message.create(room: room, user: user, content: params[:content])
		redirect_to room_path(params[:room_id])
	end
end
