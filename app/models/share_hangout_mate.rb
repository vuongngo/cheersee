class ShareHangoutMate < ActiveRecord::Base
	belongs_to :user
	belongs_to :share_hangout
end
