class CommentsController < ApplicationController
	def index
		@post = Post.find(params[:post_id])
		@comments = @post.comments.all
		@comment = @post.comments.build
	end

	def create
		@post = Post.find(params[:comment][:post_id])
		@comment = Comment.new(comment_params)
		if @comment.save
			flash[:success] = 'Comment added!'
		else
			flash[:error] = 'Something went wrong! Comment was not added!'
		end

		redirect_to user_path(@post.user)
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		flash[:success] = 'Comment removed!'
		redirect_to user_path(@comment.post.user)
	end

	private
	def comment_params
		params.require(:comment).permit(:content, :post_id, :commenter_id)
	end
end
