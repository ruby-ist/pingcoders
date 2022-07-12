class AddressesController < ApplicationController

    before_action :authenticate_user!
    
    def new
        @user = User.find(params[:profile_id])
    end

    def create
        user = current_user
        user.addresses << Address.create(address: params[:address])
        redirect_to new_profile_address_path(user.id)
    end
    
    def edit
        @profile_id = params[:profile_id]
        @address = Address.find params[:id]
    end
    
    def update
        @address = Address.find(params[:id])
        @profile_id = params[:profile_id]

        if @address.update(address: params[:address])
            redirect_to new_profile_address_path(@profile_id)
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        address = Address.find(params[:id])
        address.destroy
        redirect_to new_profile_address_path(params[:profile_id]), status: :see_other
    end

end
