class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :trackable, :validatable

  #Ex. User.first.friendship_requesters should search the friendships table for
  #rows where User.first.id = friendships.friendship_accepter_id, and then return
  #the users identified by the friendship_requester_id column (ex. for user Homer Simpson,
  #we are searching for friends for which we accepted their friendships, i.e where those
  #friends were the friendship requesters).

  has_many :requesting_friendships, class_name: "Friendship",
  																 foreign_key: :friendship_requester_id
  has_many :accepting_friendships, class_name: "Friendship",
  																foreign_key: :friendship_accepter_id

  has_many :friendship_requesters, through: :accepting_friendships
  has_many :friendship_accepters, through: :requesting_friendships

  validates :first_name, presence: true
  validates :last_name, presence: true
end