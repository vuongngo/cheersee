class TimeManagement < ActiveRecord::Base
	has_many :feedbacks
	validates :manage, presence: :true, uniqueness: :true
	validates_associated :feedbacks
end
