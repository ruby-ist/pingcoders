class AchievementsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user
	before_action :set_achievement, only: %i[ show edit update destroy ]

	# GET /achievements or /achievements.json
	def index
		@achievements = @user.achievements
	end

	# GET /achievements/1 or /achievements/1.json
	def show
	end

	# GET /achievements/new
	def new
		@achievement = Achievement.new
	end

	# GET /achievements/1/edit
	def edit
	end

	# POST /achievements or /achievements.json
	def create
		@achievement = Achievement.new(achievement_params)
		@achievement.user = current_user

		respond_to do |format|
			if @achievement.save
				format.html { redirect_to profile_achievement_url(current_user.id, @achievement), notice: "Achievement was successfully created." }
				format.json { render :show, status: :created, location: @achievement }
			else
				format.html { render :new, status: :unprocessable_entity }
				format.json { render json: @achievement.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /achievements/1 or /achievements/1.json
	def update
		respond_to do |format|
			if @achievement.update(achievement_params)
				format.html { redirect_to profile_achievement_url(current_user.id, @achievement), notice: "Achievement was successfully updated." }
				format.json { render :show, status: :ok, location: @achievement }
			else
				format.html { render :edit, status: :unprocessable_entity }
				format.json { render json: @achievement.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /achievements/1 or /achievements/1.json
	def destroy
		@achievement.destroy

		respond_to do |format|
			format.html { redirect_to profile_achievements_url(current_user.id), notice: "Achievement was successfully destroyed." }
			format.json { head :no_content }
		end
	end

	private

	def set_user
		@user = User.find params[:profile_id]
	end

	# Use callbacks to share common setup or constraints between actions.
	def set_achievement
		@achievement = Achievement.find(params[:id])
	end

	# Only allow a list of trusted parameters through.
	def achievement_params
		params.permit(:description, :image_url)
	end
end
