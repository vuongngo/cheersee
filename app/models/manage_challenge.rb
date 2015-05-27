class ManageChallenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :set_challenge
  validates_presence_of :user_id, :set_challenge_id
  validates_uniqueness_of :user_id, :scope => [:set_challenge_id]
end
