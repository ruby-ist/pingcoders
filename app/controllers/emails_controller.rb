class EmailsController < ApplicationController

    before_action :authenticate_user!

    def new
        @user = User.find(params[:profile_id])
    end

    def create
        user = User.find(params[:profile_id])
        user.emails << Email.create(email: params[:email])
        redirect_to new_profile_email_path(user.id)
    end

    def edit
        @profile_id = params[:profile_id]
        @email = Email.find params[:id]
    end

    def update
        @email = Email.find(params[:id])
        @profile_id = params[:profile_id]

        if @email.update(email: params[:email])
            redirect_to new_profile_email_path(@profile_id)
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        email = Email.find(params[:id])
        email.destroy
        redirect_to new_profile_email_path(params[:profile_id]), status: :see_other
    end

end
