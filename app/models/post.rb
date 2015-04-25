class Post < ActiveRecord::Base
	belongs_to :user
	has_many :likes, as: :likeable
	has_many :comments

	validates :content, presence: true
end
