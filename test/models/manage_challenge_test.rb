require "test_helper"

class ManageChallengeTest < ActiveSupport::TestCase

  def setup
    @manage_challenge = ManageChallenge.new(user_id: 1, set_challenge_id: 1)
  end

  test "manage challenge exist" do
  	assert @manage_challenge.valid?
  end

  test "validate manage challenge if user_id does not exist" do
  	@manage_challenge.user_id = "  "
  	assert_not @manage_challenge.valid?
  end

  test "validate manage challenge if set_challenge_id does not exist" do
  	@manage_challenge.set_challenge_id = "  "
  	assert_not @manage_challenge.valid?
  end

  test "validate uniqueness of manage challenge" do
  	@manage_challenge.save!
  	@manage_challenge1 = ManageChallenge.new(user_id: 1, set_challenge_id: 1)
  	assert_not @manage_challenge1.valid?
  end
end
