class ProfilesController < ApplicationController

	include ProfilesHelper

	before_action :authenticate_user!, except: [:show]

	def index
		@search = true
		redirect_to profile_path(current_user.id)
	end

	def show
		(@user, @repos, @liked, @counts) = get_repo_details(params[:id])
		@connection = if user_signed_in?
			Connection.find_by(sent_id: current_user.id, received_id: params[:id]) || Connection.find_by(sent_id: params[:id], received_id: current_user.id)
		else
			nil
		end
		@connection_count = Connection.where(sent_id: params[:id], status: :accepted).or(Connection.where(received_id: params[:id], status: :accepted)).count
	end

	def edit
		redirect_to new_user_session_path unless current_user
		(@user, @repos, @liked, @counts) = get_repo_details(params[:id])
	end

	def update
		fields = params.require(:user).permit(:name, :image_url, :github_username, :hackerrank_username, :stackoverflow_url, :linkedin_url, :portfolio_url)
		user = current_user
		if user.update(fields)
			redirect_to profile_path(user.id)
		end
	end

	def picture
		user = current_user
		account = UserFinder.new
		url = account.find_pic user.github_username
		user.update(image_url: url)
		redirect_to profile_path(user.id)
	end

	def resume
		@user = User.includes(:repos, :languages, :skills, :addresses, :numbers, :achievements, :companies, :emails, :educations).find(params[:profile_id])
		html = render_to_string "resume/resume", layout: false
		pdf = WickedPdf.new.pdf_from_string(html)
		send_data pdf, filename: "resume", type: "application/pdf"
	end

	private

	def get_repo_details(id)
		user = User.find id
		repos = user.repos.reverse
		liked = []
		counts = []
		repos.each do |repo|
			id = nil
			likes = Like.where(repo_id: repo.id).to_a
			likes.each do |i|
				if user_signed_in? && i.user_id == current_user.id
					id = i.id
				end
			end
			liked << id
			counts << likes.length
		end
		[user, repos, liked, counts]
	end

end
