class PostsController < ApplicationController

	include NotificationsHelper

	before_action :authenticate_user!, except: %i[index show]
	before_action :set_post, only: %i[ show edit update destroy ]
	before_action :set_section

	# GET /posts or /posts.json
	def index
		posts = Post.includes(:skills).order created_at: :desc
		user_skills = current_user.skills.map(&:name) + current_user.languages.map(&:name)
		@posts = posts.select do |post|
			!(post.skills.map(&:name) & user_skills).empty?
		end
		@posts = posts if @posts.empty?
	end

	# GET /posts/1 or /posts/1.json
	def show
	end

	# GET /posts/new
	def new
		@post = Post.new
	end

	# GET /posts/1/edit
	def edit
	end

	# POST /posts or /posts.json
	def create
		@post = Post.new(post_params)

		respond_to do |format|
			if @post.save
				params[:post][:required_skills].split(",").map(&:strip).each do |name|
					name = name.gsub("-", " ").capitalize
					@post.skills << Skill.find_or_create_by(name: name)
				end
				create_notification :job, @post.id
				format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
				format.json { render :show, status: :created, location: @post }
			else
				format.html { render :new, status: :unprocessable_entity }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /posts/1 or /posts/1.json
	def update
		respond_to do |format|
			if @post.update(post_params)
				skills = @post.skills.map(&:name)

				new_skills = params[:post][:required_skills].split(",").map do |name|
					name.strip.gsub("-", " ").capitalize
				end

				(new_skills - skills).each do |name|
					@post.skills << Skill.find_or_create_by(name: name)
				end

				format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
				format.json { render :show, status: :ok, location: @post }
			else
				format.html { render :edit, status: :unprocessable_entity }
				format.json { render json: @post.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /posts/1 or /posts/1.json
	def destroy
		@post.destroy

		respond_to do |format|
			format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
			format.json { head :no_content }
		end
	end

	private

	# Use callbacks to share common setup or constraints between actions.
	def set_post
		@post = Post.find(params[:id])
		@user = @post.user
	end

	# Only allow a list of trusted parameters through.
	def post_params
		params.require(:post).permit(:role, :project, :body, :user_id)
	end

	def set_section
		@section = 1
	end
end
