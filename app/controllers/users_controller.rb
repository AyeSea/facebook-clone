class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def show
		if current_user == User.find(params[:id])
			@user = current_user
		else
			@user = User.find(params[:id])
		end

		@posts = @user.posts
	end

	def destroy
		@user = User.find(params[:id])
		if current_user != @user
			flash[:error] = "Can't delete other users' accounts!"
			redirect_to root_path
		else
			@user.destroy
			flash[:success] = "Account successfully closed."
			redirect_to root_path
		end	
	end
end
