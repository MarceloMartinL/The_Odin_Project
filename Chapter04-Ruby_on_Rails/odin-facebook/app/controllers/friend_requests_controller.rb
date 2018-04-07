class FriendRequestsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_friend_request, except: [:index, :create]

	def create
		@user = User.find(params[:friend_id])
		@friend_request = current_user.friend_requests.new(friend: @user)

		if @friend_request.save
			flash[:success] = "Friend Request Sended!"
		else
			flash[:danger] = "Invalid Request"
		end
		redirect_to request.referrer || root_url
		respond_to do |format|
			format.html { redirect_to current_user }
			format.js
		end
	end

	def index
		@incoming = FriendRequest.where(friend: current_user)
		@outgoing = current_user.friend_requests
	end

	def update
		@friend_request.accept
		flash[:success] = "New friend added!"
		redirect_to friend_requests_path
	end

	def destroy
		@user = @friend_request.friend
		@friend_request.destroy
		flash[:danger] = "Friend request eliminated!"
		redirect_to request.referrer || root_url
		respond_to do |format|
			format.html { redirect_to current_user }
			format.js
		end
	end

	private

		def set_friend_request
			@friend_request = FriendRequest.find(params[:id])
		end

end
