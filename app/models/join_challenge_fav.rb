class JoinChallengeFav < ActiveRecord::Base
  belongs_to :join_challenge
  belongs_to :user
  validates_presence_of :join_challenge_id, :user_id
  validates_uniqueness_of :join_challenge_id, :scope => [:user_id]
end
