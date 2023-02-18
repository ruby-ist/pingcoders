class RoomsController < ApplicationController

	before_action :authenticate_user!
	before_action :assign_variables, only: [:index, :show]

	def index
	end

	def show
		@room = Room.new
		@user = User.find params[:id].to_i
		@rooms.each do |r|
			if r.users.include? @user
				@room = r
			end
		end
		@messages = @room ? @room.messages : []
	end

	private

	def assign_variables
		room_users = RoomUser.where(user: current_user)
		@rooms = room_users.map { |i| i.room }.sort_by {|room| room.messages.last.created_at}.reverse
		@users = @rooms.map { |room| (room.users - [current_user])[0] }
		@section = 3
	end

end