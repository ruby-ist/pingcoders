class AddressesController < ApplicationController

    before_action :authenticate_user!

    def create
        user = current_user
        user.addresses << Address.create(address: params[:address])
        redirect_to edit_profile_path(user.id)
    end

end
