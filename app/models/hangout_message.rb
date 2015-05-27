class HangoutMessage < ActiveRecord::Base
  belongs_to :hangout
  belongs_to :user
  validates_presence_of :hangout_id, :user_id, :content
end
