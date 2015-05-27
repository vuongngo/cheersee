class SetChallengeFav < ActiveRecord::Base
  belongs_to :set_challenge
  belongs_to :user
  validates_presence_of :set_challenge_id, :user_id
  validates_uniqueness_of :set_challenge_id, :scope => [:user_id]
end
