class Notification < ApplicationRecord
	belongs_to :user

	has_many :user_alerts, dependent: :destroy
	has_many :users, through: :user_alerts

	enum kind: [:request, :repo, :job, :accepted]
end
