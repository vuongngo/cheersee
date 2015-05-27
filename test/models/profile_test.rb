require "test_helper"

class ProfileTest < ActiveSupport::TestCase

  def setup
    @profile = Profile.new(user_id: 1, intro: "Hi there")
  end

  test "user profile exist" do 
  	assert @profile.valid?
  end

  test "validate profile if user_id does not exist" do
  	@profile.user_id = "  "
  	assert_not @profile.valid?
  end

  test "validate uniqueness of user profile" do
  	@profile.save!
  	@profile1 = Profile.new(user_id: 1)
  	assert_not @profile1.valid?
  end

end
