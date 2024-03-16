class Skill < ApplicationRecord
    has_many :skill_sets
    has_many :users, through: :skill_sets

    has_many :post_skills
    has_many :posts, through: :post_skills
end
