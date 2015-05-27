class JoinChallengeComment < ActiveRecord::Base
  belongs_to :join_challenge
  belongs_to :user
  validates_presence_of :join_challenge_id, :user_id, :comment
  sync :all

  sync_scope :by_join_challenge, ->(join_challenge) { where(join_challenge_id: join_challenge.id) }
end
