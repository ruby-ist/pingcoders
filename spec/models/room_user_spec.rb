require 'rails_helper'

RSpec.describe RoomUser, type: :model do
    let(:user) { User.create!(email: "srira123@bitsathy.ac.in", password: "1234567") }
    let(:room) { Room.create }

    it "cannot be created without user and room" do
        room_user = RoomUser.new
        expect(room_user.save).to be_falsey

        room_user.user = user
        room_user.room = room
        expect(room_user.save).not_to be_falsey
    end

    it "can be deleted when user is deleted" do
        count = RoomUser.all.size
        RoomUser.create(user: user, room: room)
        expect(RoomUser.all.size).to eq(count + 1)
        user.destroy
        expect(RoomUser.all.size).to eq(count)
    end

    it "can be deleted when room is deleted" do
        count = RoomUser.all.size
        RoomUser.create(user: user, room: room)
        expect(RoomUser.all.size).to eq(count + 1)
        room.destroy
        expect(RoomUser.all.size).to eq(count)
    end

    it "gives Room users attribute" do
        RoomUser.create(user: user, room: room)
        expect(room.users.include? user).to be_truthy
    end
end
