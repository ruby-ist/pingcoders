class CompaniesController < ApplicationController

	before_action :authenticate_user!

	def new
		@user = User.find(params[:profile_id])
	end

	def create
		user = User.find(params[:profile_id])
		user.companies << Company.create(name: params[:name], role: params[:role])
		redirect_to new_profile_company_path(user.id)
	end

	def edit
		@profile_id = params[:profile_id]
		@company = Company.find params[:id]
	end

	def update
		@company = Company.find(params[:id])
		@profile_id = params[:profile_id]

		if @company.update(name: params[:name], role: params[:role])
			redirect_to new_profile_company_path(@profile_id)
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		company = Company.find(params[:id])
		company.destroy
		redirect_to new_profile_company_path(params[:profile_id]), status: :see_other
	end

end
