class CommentsController < ApplicationController
	before_action :authenticate_user!
	
	def create
		@post = Post.find(params[:comment][:post_id])
		@comment = @post.comments.build(comment_params)
		if @comment.save
			redirect_to request.referrer || root_url
		else
			flash[:danger] = "Comment error"
			redirect_to request.referrer || root_url
		end

	end

	def destroy
	end

	private
		def comment_params
			params.require(:comment).permit(:body, :user_id)
		end
end
