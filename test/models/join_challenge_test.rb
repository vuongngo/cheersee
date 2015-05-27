require "test_helper"

class JoinChallengeTest < ActiveSupport::TestCase

  def setup
    @join_challenge = JoinChallenge.new(user_id: 1, set_challenge_id: 1, point: 20, longitude: 34.554423, latitude: 34.422323, content: "Ohlala", no_of_fav: 0)
  end

  test "join challenge exist" do
  	assert @join_challenge.valid?
  end

  test "validate join challenge if user_id does not exist" do
  	@join_challenge.user_id = "  "
  	assert_not @join_challenge.valid?
  end

  test "validate join challenge if set_challenge_id does not exist" do
  	@join_challenge.set_challenge_id = "  "
  	assert_not @join_challenge.valid?
  end

  test "validate join challenge if point does not exist" do
  	@join_challenge.point = "  "
  	assert_not @join_challenge.valid?
  end

  test "validate join challenge if longitude does not exist" do
  	@join_challenge.longitude = "  "
  	assert_not @join_challenge.valid?
  end

  test "validate join challenge if latitude does not exist" do
  	@join_challenge.latitude = "  "
  	assert_not @join_challenge.valid?
  end

  test "validate join challenge if content does not exist" do
  	@join_challenge.content = "  "
  	assert_not @join_challenge.valid?
  end

  test "validate join challenge if no_of_fav does not exist" do
    @join_challenge.no_of_fav = "  "
    assert_not @join_challenge.valid?
  end

  test "validate uniqueness of join challenge" do
  	@join_challenge.save!
    @join_challenge1 = JoinChallenge.new(user_id: 1, set_challenge_id: 1, point: 20, longitude: 54.554423, latitude: 74.422323, content: "Holle")
    assert_not @join_challenge1.valid?
  end
  
end
