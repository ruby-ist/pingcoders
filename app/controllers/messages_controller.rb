class MessagesController < ApplicationController

	before_action :authenticate_user!

	def create
		room = Room.find_by id: params[:room]
		if room == nil
			room = Room.create
			room.users << current_user
			room.users << User.find(params[:room_id])
		end
		user = current_user
		Message.create(room: room, user: user, content: params[:content])
		redirect_to room_path(params[:room_id])
	end
end
