class AdminsController < ApplicationController
	before_action :set_section, :authenticate_user!

	def index
		@posts_count = Post.count
		@users_count = User.count
	end

	private

	def set_section
		@section = 0
	end
end
