class NumbersController < ApplicationController

    before_action :authenticate_user!

    def create
        user = current_user
        user.numbers << Number.create(number: params[:number])
        redirect_to edit_profile_path(user.id)
    end
end
