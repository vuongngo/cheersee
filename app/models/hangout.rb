class Hangout < ActiveRecord::Base
	has_many :who_hangouts, dependent: :destroy
	has_many :hangout_messages, dependent: :destroy
	validates_presence_of :latitude, :longitude, :share_time
end
