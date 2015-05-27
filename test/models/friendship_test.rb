require "test_helper"

class FriendshipTest < ActiveSupport::TestCase

  def setup
    @friendship = Friendship.new(user_id: 1, friend_id: 2)
  end

  test "friendship exist" do
  	assert @friendship.valid?
  end

  test "validate friendship if user_id does not exist" do
  	@friendship.user_id = "  "
  	assert_not @friendship.valid?
  end

  test "validate friendship if friend_id does not exist" do
  	@friendship.friend_id = "  "
  	assert_not @friendship.valid?
  end

  test "validate uniqueness of friendship" do
  	@friendship.save!
  	@friendship1 = Friendship.new(user_id: 1, friend_id: 2)
  	assert_not @friendship1.valid?
  end

end
