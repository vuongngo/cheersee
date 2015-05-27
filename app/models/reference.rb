class Reference < ActiveRecord::Base
  default_scope -> { order('created_at DESC') }	
	belongs_to :user
	belongs_to :receiver, :class_name => "User"
	belongs_to :hangout
	has_one :feedback, dependent: :destroy
	has_many :general_notifications
	validates_presence_of :user_id, :hangout_id, :receiver_id
	validates_uniqueness_of :user_id, :scope => [:hangout_id, :receiver_id]
end
