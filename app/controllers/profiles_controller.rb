class ProfilesController < ApplicationController
    include ProfilesHelper

    before_action :authenticate_user!, except: [:show]

    def initialize
        super
        @stack = StackExchange.new
        @git = Github.new
    end

    def index
        redirect_to profile_path(current_user.id)
    end

    def show
        @user = User.find params[:id]
    end

    def edit
        redirect_to new_user_session_path unless current_user
        @user = current_user
    end

    def update
        @user = current_user
        case params[:attribute]
        when "email"
            @user.emails << Email.create(email: params[:email])
        when "number"
            @user.numbers << Number.create(number: params[:number])
        when "address"
            @user.addresses << Address.create(address: params[:address])
        end
        redirect_to profile_path(1)
    end

    def find
        data = []
        case params[:type]
        when "language"
            data = @stack.find_language(params[:q])
            data -= current_user.languages.map { |i| i[:name] }
        when "skill"
            data = @stack.find_skill(params[:q])
            data -= current_user.skills.map { |i| i[:name] }
        when "repos"
            if current_user.github_username == nil
                render json: data
                return
            end
            data = @git.find_repo(current_user.github_username, params[:q] )
            data -= current_user.repos.map{ |i| i[:name]} #unchecked change
        end
        render json: data.first(10)
    end

    def language
        user = current_user
        name = params[:name]
        language = Language.find_or_create_by(name: name)
        user.languages << language
        redirect_to edit_profile_path(user.id)
    end

    def skill
        user = current_user
        name = params[:name].gsub("-"," ").capitalize
        skill = Skill.find_or_create_by(name: name)
        user.skills << skill
        redirect_to edit_profile_path(user.id)
    end

    def colors
        file = File.open(Rails.root + "lib/assets/colors.json")
        render json: JSON.load(file)
    end

    def project
        user = current_user
        name = params[:name]
        user.repos << Repo.create(name: name)
        redirect_to edit_profile_path(user.id)
    end

    def account

    end

end
