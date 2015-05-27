class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => "User" 
	has_many :friend_messages, dependent: :destroy
	validates_presence_of :user_id, :friend_id
	validates_uniqueness_of :user_id, :scope => [:friend_id]
end
