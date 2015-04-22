class FriendshipsController < ApplicationController
	def index
		@pending_friendships = current_user.pending_friendships
	end

	def new
	end

	def create
		@friendship = current_user.requesting_friendships.build(friendship_accepter_id: params[:accepter_id])
		if @friendship.save
			flash[:success] = 'Friend Request Sent!'
			redirect_to user_path(User.find(params[:accepter_id]))
		else
			flash[:error] = 'Uh oh! Something went wrong!'
			redirect_to user_path(User.find(params[:accepter_id]))
		end
	end

	def confirm
		@friendship = current_user.accepting_friendships.find_by(friendship_requester_id: params[:requester_id])
		@friend = User.find(params[:requester_id])
		
		@friendship.update_attribute(:established, true)
		flash[:success] = "Added #{@friend.first_name} #{@friend.last_name}!"
		redirect_to @friend
	end

	def destroy
		@friendship = current_user.accepting_friendships.find_by(friendship_requester_id: params[:requester_id])
		@friend = User.find(params[:requester_id])
		@friendship.destroy
		flash[:success] = "Rejected request from #{@friend.first_name} #{@friend.last_name}!"
		redirect_to @friend
	end
end
