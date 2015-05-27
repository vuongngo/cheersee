class RequestHangout < ActiveRecord::Base
  belongs_to :user
  belongs_to :share_hangout
  validates_presence_of :user_id, :share_hangout_id, :mes
  validates_uniqueness_of :user_id, :scope => [:share_hangout_id]
end
