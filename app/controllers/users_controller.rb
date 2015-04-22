class UsersController < ApplicationController
	def show
		if current_user == User.find(params[:id])
			@user = current_user
		else
			@user = User.find(params[:id])
		end
	end
end
