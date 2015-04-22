class Friendship < ActiveRecord::Base
	belongs_to :friendship_requester, class_name: "User"
	belongs_to :friendship_accepter, class_name: "User"
end