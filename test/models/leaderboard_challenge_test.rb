require "test_helper"

class LeaderboardChallengeTest < ActiveSupport::TestCase

  def setup
    @leaderboard_challenge = LeaderboardChallenge.new(set_challenge_id: 1, first_place: 1, first_point: 60, first_badge: nil, second_place: 2, second_point: 40, second_badge: nil, third_place: 3, third_point: 30, third_badge: nil)
  end

  test "leaderboard challenge exist" do
  	assert @leaderboard_challenge.valid?
  end

  test "validate uniqueness of leaderboard challenge" do
  	@leaderboard_challenge.save!
    @leaderboard_challenge1 = LeaderboardChallenge.new(set_challenge_id: 1, first_place: 1, first_point: 60, first_badge: nil, second_place: 2, second_point: 40, second_badge: nil, third_place: 3, third_point: 30, third_badge: nil)
    assert_not @leaderboard_challenge1.valid?
  end
end
