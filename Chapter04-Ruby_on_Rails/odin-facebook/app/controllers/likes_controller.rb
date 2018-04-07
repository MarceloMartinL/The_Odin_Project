class LikesController < ApplicationController
	before_action :authenticate_user!, only: [:create, :destroy]

	def create
		like = Like.new(user_id: params[:user_id], post_id: params[:post_id])
		if like.save
			redirect_to request.referrer || root_url
		end

	end

	def destroy
		@like = Like.find(params[:id])
		@like.destroy
		redirect_to request.referrer || root_url
	end

end
