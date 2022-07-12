class SkillsController < ApplicationController

    include SkillsHelper
    before_action :authenticate_user!, only: [:create]

    def initialize
        super
        @skills = SkillsFinder.new
    end

    def index
        data = @skills.find(params[:q]) || []
        data -= current_user.skills.map { |i| i[:name] } if current_user
        render json: data.first(25)
    end

    def create
        user = current_user
        name = params[:name].gsub("-"," ").capitalize
        skill = Skill.find_or_create_by(name: name)
        user.skills << skill
        redirect_to edit_profile_path(user.id)
    end

    def destroy
        skill = SkillSet.find_by(user_id: params[:profile_id], skill_id: params[:id])
        skill.destroy
        redirect_to edit_profile_path(params[:profile_id]), status: :see_other
    end
end
