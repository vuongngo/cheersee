class FriendMessage < ActiveRecord::Base
	belongs_to :friendship
	belongs_to :user
	validates_presence_of :friendship_id, :user_id, :content
end
