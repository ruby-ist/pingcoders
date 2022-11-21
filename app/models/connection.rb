class Connection < ApplicationRecord
	enum status: [:requested, :accepted]
end
