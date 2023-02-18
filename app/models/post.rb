class Post < ApplicationRecord
  belongs_to :user
  has_many :post_skills
  has_many :skills, through: :post_skills

end
