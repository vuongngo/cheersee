require "test_helper"

class JoinChallengeFavTest < ActiveSupport::TestCase

  def setup
    @join_challenge_fav = JoinChallengeFav.new(join_challenge_id: 1, user_id: 1)
  end

  test "join challenge favorite exist" do
  	assert @join_challenge_fav.valid?
  end

  test "validate join challenge favorite if join_challenge_id does not exist" do
  	@join_challenge_fav.join_challenge_id = "  "
  	assert_not @join_challenge_fav.valid?
  end

  test "validate join challenge favorite if user_id does not exist" do
  	@join_challenge_fav.user_id = "  "
  	assert_not @join_challenge_fav.valid?
  end

  test "validate uniqueness of join challenge favorite" do
  	@join_challenge_fav.save!
    @join_challenge_fav1 = JoinChallengeFav.new(join_challenge_id: 1, user_id: 1)
	assert_not @join_challenge_fav1.valid?
  end  	

end
