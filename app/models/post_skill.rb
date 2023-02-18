class PostSkill < ApplicationRecord
	belongs_to :post
	belongs_to :skill
end
