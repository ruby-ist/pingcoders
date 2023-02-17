class EducationsController < ApplicationController

	before_action :authenticate_user!

	def new
		@user = User.find(params[:profile_id])
	end

	def create
		user = User.find(params[:profile_id])
		user.educations << Education.create(institute: params[:institute], degree: params[:degree], percentage: params[:percentage].to_f, passed_year: params[:passed_year].to_i)
		redirect_to new_profile_education_path(user.id)
	end

	def edit
		@profile_id = params[:profile_id]
		@education = Education.find params[:id]
	end

	def update
		@education = Education.find(params[:id])
		@profile_id = params[:profile_id]

		if @education.update(institute: params[:institute], degree: params[:degree], percentage: params[:percentage].to_f, passed_year: params[:passed_year].to_i)
			redirect_to new_profile_education_path(@profile_id)
		else
			render :edit, status: :unprocessable_entity
		end
	end

	def destroy
		education = Education.find(params[:id])
		education.destroy
		redirect_to new_profile_education_path(params[:profile_id]), status: :see_other
	end

end

