class MessageModels < ActiveRecord::Migration[7.0]
    def up
        create_table :rooms do |t|
            t.timestamps
        end

        create_table :room_users do |t|
            t.belongs_to :user
            t.belongs_to :room

            t.timestamps
        end

        create_table :messages do |t|
            t.text :content
            t.belongs_to :room
            t.belongs_to :user

            t.timestamps
        end
    end

    def down
        drop_table :rooms
        drop_table :room_users
        drop_table :messages
    end
end
