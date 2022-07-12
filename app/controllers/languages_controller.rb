class LanguagesController < ApplicationController

    include LanguagesHelper
    before_action :authenticate_user!, only: [:create]

    def initialize
        super
        @languages = LanguageFinder.new
    end

    def index
        data = @languages.find(params[:q]) || []
        data -= current_user.languages.map { |i| i[:name] } if current_user
        render json: data.first(25)
    end

    def create
        user = current_user
        name = params[:name]
        language = Language.find_or_create_by(name: name)
        user.languages << language
        redirect_to edit_profile_path(user.id)
    end

    def destroy
        language = KnownLanguage.find_by(user_id: params[:profile_id], language_id: params[:id])
        language.destroy
        redirect_to edit_profile_path(params[:profile_id]), status: :see_other
    end
end
