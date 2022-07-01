class ProfilesController < ApplicationController
    include ProfilesHelper

    def initialize
        super
        @stack = StackExchange.new
    end

    def index
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

end