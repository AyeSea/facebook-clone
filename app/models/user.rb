class User < ActiveRecord::Base
  attr_accessor :friends, :pending_friendships, :active_friendships
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

  has_many :posts
  has_many :likes

  validates :first_name, presence: true
  validates :last_name, presence: true

  def friends
   @friends ||= self.friendship_requesters + self.friendship_accepters
  end

  def pending_friendships
    @pending_friendships = self.accepting_friendships.where('established = ?', false)
  end

  def active_friendships
    @active_friendships = requested_active_friendships + accepted_active_friendships
  end

  def requested_active_friendships
    self.requesting_friendships.where('established = ?', true)
  end

  def accepted_active_friendships
    self.accepting_friendships.where('established = ?', true)
  end
end