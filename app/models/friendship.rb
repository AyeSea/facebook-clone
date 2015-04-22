class Friendship < ActiveRecord::Base
	belongs_to :friendship_requester, class_name: "User"
	belongs_to :friendship_accepter, class_name: "User"

	def self.requesting(requester, accepter)
		requester.requesting_friendships.find_by(friendship_accepter_id: accepter.id)
	end

	def self.accepting(accepter, requester)
		accepter.accepting_friendships.find_by(friendship_requester_id: requester.id)
	end

end