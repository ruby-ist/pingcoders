class ProfilesController < ApplicationController

    before_action :authenticate_user!, except: [:show]

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
        fields = params.require(:user).permit(:name, :image_url, :github_username, :hackerrank_username, :stackoverflow_url, :linkedin_url, :portfolio_url)
        user = current_user
        user.update(fields)
        redirect_to profile_path(user.id)
    end

end
