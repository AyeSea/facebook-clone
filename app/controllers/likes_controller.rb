class LikesController < ApplicationController
	before_action :identify_like_by_user_and_post

	def create
		@like = @post.likes.create(user_id: @user.id)

		if @like.save
			flash[:success] = "Post was liked!"
		else
			flash[:error] = "Something went wrong! You couldn't like the post!" 
		end

		redirect_to user_path(@post.user)
	end

	def destroy
		@like = @post.likes.where('user_id = ?', @user.id)
		@like.destroy_all

		flash[:success] = "Post was unliked!"
		redirect_to user_path(@post.user)
	end

	private
		def identify_like_by_user_and_post
			@user = current_user
			@post = Post.find(params[:post_id])
		end

end
