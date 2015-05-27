class SetChallengeComment < ActiveRecord::Base
	belongs_to :set_challenge
	belongs_to :user
    validates_presence_of :set_challenge_id, :user_id, :comment
    sync :all

    sync_scope :by_set_challenge, ->(set_challenge) { where(set_challenge_id: set_challenge.id) }
end
