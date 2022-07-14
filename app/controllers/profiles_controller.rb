class ProfilesController < ApplicationController

    before_action :authenticate_user!

    def index
        redirect_to profile_path(current_user.id)
    end

    def show
        (@user, @repos, @liked, @counts) = get_repo_details(params[:id])
    end

    def edit
        redirect_to new_user_session_path unless current_user
        (@user, @repos, @liked, @counts) = get_repo_details(params[:id])
    end

    def update
        fields = params.require(:user).permit(:name, :image_url, :github_username, :hackerrank_username, :stackoverflow_url, :linkedin_url, :portfolio_url)
        user = current_user
        if user.update(fields)
            redirect_to profile_path(user.id)
        end
    end

    private

    def get_repo_details(id)
        user = User.find params[:id]
        repos = user.repos.reverse
        liked = []
        counts = []
        repos.each do |repo|
            id = nil
            likes = Like.where(repo_id: repo.id).to_a
            likes.each do |i|
                if i.user_id == current_user.id
                    id = i.id
                end
            end
            liked << id
            counts << likes.length
        end
        [user, repos, liked, counts]
    end

end
