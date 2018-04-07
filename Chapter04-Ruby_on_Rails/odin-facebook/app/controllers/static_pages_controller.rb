class StaticPagesController < ApplicationController

	def home
		if user_signed_in?
			@user = current_user
			@post = current_user.posts.build
			@feed_items = current_user.feed.paginate(page: params[:page])
			@comment = Comment.new
		end
	end
end
