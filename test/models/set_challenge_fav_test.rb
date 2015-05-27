require "test_helper"

class SetChallengeFavTest < ActiveSupport::TestCase

  def setup
    @set_challenge_fav = SetChallengeFav.new(set_challenge_id: 1, user_id: 1)
  end

  test "set challenge favorite exist" do
  	assert @set_challenge_fav.valid?
  end

  test "validate set challenge favorite if set_challenge_id does not exist" do
  	@set_challenge_fav.set_challenge_id = "  "
  	assert_not @set_challenge_fav.valid?
  end

  test "validate set challenge favorite if user_id does not exist" do
  	@set_challenge_fav.user_id = "  "
  	assert_not @set_challenge_fav.valid?
  end

  test "validate uniqueness of set challenge favorite" do
  	@set_challenge_fav.save!
    @set_challenge_fav1 = SetChallengeFav.new(set_challenge_id: 1, user_id: 1)
	assert_not @set_challenge_fav1.valid?
  end  	
end
