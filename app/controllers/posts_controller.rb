class PostsController < ApplicationController
	before_action :identify_user, only: [:index, :new, :create, :destroy]

	def new
		@post = @user.posts.build
	end

	def create
		@post = @user.posts.build(post_params)
		if @post.save
			flash[:success] = "Created new post!"
			redirect_to user_path(@user)
		else
			flash.now[:error] = "Something went wrong! Your post wasn't created..."
			render 'new'
		end
	end

	def destroy
		@post = @user.posts.find(params[:id])
		@post.destroy
		flash[:success] = 'Post deleted!'
		redirect_to @user
	end

	private
	def identify_user
		@user = User.find(params[:user_id])
	end

	def post_params
		params.require(:post).permit(:content)
	end

end
