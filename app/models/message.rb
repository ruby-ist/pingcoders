class Message < ApplicationRecord
	belongs_to :user
	belongs_to :room

	validates :content, presence: true

	after_create_commit -> { broadcast_append_to "room", target: "messages_#{self.room.id}" }
	after_create_commit -> { broadcast_replace_to "room", partial: "rooms/room", locals: {room: self.room, user: self.user}, target: "room_#{self.room.id}"}
end
