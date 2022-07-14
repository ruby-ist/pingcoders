class User < ApplicationRecord
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable, :trackable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2, :github]

    has_many :skill_sets
    has_many :skills, through: :skill_sets
    has_many :known_languages
    has_many :languages, through: :known_languages

    has_many :numbers, dependent: :destroy
    has_many :emails, dependent: :destroy
    has_many :addresses, dependent: :destroy
    has_many :repos, dependent: :destroy
    has_many :likes, dependent: :destroy

    before_update do
        self.name = self.name.presence
        self.github_username = self.github_username.presence
        self.image_url = self.image_url.presence
        self.portfolio_url = self.portfolio_url.presence
        self.hackerrank_username = self.hackerrank_username.presence
        self.stackoverflow_url = self.stackoverflow_url.presence
        self.linkedin_url = self.linkedin_url.presence
    end

    def self.from_omniauth(auth, type)
        if type == "google"
          return where(email: auth.info.email).first_or_create do |user|
                user.email = auth.info.email
                user.password = Devise.friendly_token[0, 20]
                # user.name = auth.info.name   # assuming the user model has a name
                # user.image = auth.info.image # assuming the user model has an image
                # If you are using confirmable and the provider(s) you use validate emails,
                # uncomment the line below to skip the confirmation emails.
                # user.skip_confirmation!
            end
        end

        if type == "github"
          return where(github_username: auth.info.nickname).first_or_create do |user|
            user.email = auth.info.email
            user.github_username = auth.info.nickname
            user.password = Devise.friendly_token[0, 20]
          end
        end
    end
end
