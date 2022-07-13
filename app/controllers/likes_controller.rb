class LikesController < ApplicationController

    before_action :authenticate_user!

    def create
        Like.create!(user_id: current_user.id, repo_id: params[:repo_id])
        redirect_to profile_path(params[:profile_id])
    end

    def destroy
        like = Like.find(params[:id])
        like.destroy
        redirect_to profile_path(params[:profile_id]), status: :see_other
    end
end
