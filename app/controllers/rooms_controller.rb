class RoomsController < ApplicationController

    before_action :authenticate_user!

    def index
        room_users = RoomUser.where(user: current_user)
        @rooms = room_users.map {|i| i.room}
        @users = @rooms.map { |room| (room.users - [current_user])[0] }
    end

    def show
        @room = Room.new
        @rooms.each do |r|
            if r.users.include params[:user]
                @room = r
            end
        end
    end

end