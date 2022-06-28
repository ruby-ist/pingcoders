class Skill < ApplicationRecord
    has_many :skill_sets
    has_many :users, through: :skill_sets
end
