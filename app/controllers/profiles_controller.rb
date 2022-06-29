class ProfilesController < ApplicationController
    include ProfilesHelper

    def index
        stack = StackExchange.new
        render json: stack.find_language("y")
    end

    def show
        @user = User.find params[:id]
    end
end
