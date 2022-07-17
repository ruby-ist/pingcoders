class NumbersController < ApplicationController

    before_action :authenticate_user!

    def new
        @user = User.find(params[:profile_id])
    end

    def create
        user = current_user
        user.numbers << Number.create(number: params[:number])
        redirect_to new_profile_number_path(user.id)
    end

    def edit
        @profile_id = params[:profile_id]
        @number = Number.find(params[:id])
    end

    def update
        @number = Number.find(params[:id])
        @profile_id = params[:profile_id]

        if @number.update(number: params[:number])
            redirect_to new_profile_number_path(@profile_id)
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        number = Number.find(params[:id])
        number.destroy
        redirect_to new_profile_number_path(params[:profile_id]), status: :see_other
    end

end
