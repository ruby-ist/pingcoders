require 'rails_helper'

RSpec.describe Room, type: :model do
    it "can be created freely" do
        room = Room.new
        expect(room.save).not_to be_falsey
    end
end
