class ReposController < ApplicationController

    include ReposHelper

    before_action :authenticate_user!

    def initialize
        super
        @repos = ReposFinder.new
    end

    def index
        if current_user.github_username == nil
            render json: []
            return
        end
        data = @repos.find(current_user.github_username, params[:q] )
        data -= current_user.repos.map{ |i| i[:name]} #unchecked change
        render json: data
    end

    def create
        user = current_user
        name = params[:name]
        user.repos << Repo.create(name: name)
        redirect_to edit_profile_path(user.id)
    end

end
