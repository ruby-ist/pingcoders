class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :skill_sets
  has_many :skills, through: :skill_sets
  has_many :known_languages
  has_many :languages, through: :known_languages


  has_many :numbers
  has_many :emails
  has_many :addresses
end
