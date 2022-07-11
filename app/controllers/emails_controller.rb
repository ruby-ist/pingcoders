class EmailsController < ApplicationController

    before_action :authenticate_user!

    def create
        user = current_user
        user.emails << Email.create(email: params[:email])
        redirect_to edit_profile_path(user.id)
    end

end
