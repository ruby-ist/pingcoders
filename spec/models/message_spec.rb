require 'rails_helper'

RSpec.describe Message, type: :model do
    let(:user) { User.create!(email: "srira123@bitsathy.ac.in", password: "1234567") }
    let(:room) { Room.create }

    it "cannot be created without user and room" do
        message = Message.new
        expect(message.save).to be_falsey
    end

    it "needs content to be created" do
        message = Message.new(user: user, room: room)
        expect(message.save).to be_falsey

        message.content = "Hey! How are you?"
        expect(message.save).not_to be_falsey
    end

    it "can be deleted when user is deleted" do
        count = Message.all.size
        Message.create(user: user, room: room, content: "Hey!")
        expect(Message.all.size).to eq(count + 1)
        user.destroy
        expect(Message.all.size).to eq(count)
    end

    it "can be deleted when room is deleted" do
        count = Message.all.size
        Message.create(user: user, room: room, content: "Hey!")
        expect(Message.all.size).to eq(count + 1)
        room.destroy
        expect(Message.all.size).to eq(count)
    end
end