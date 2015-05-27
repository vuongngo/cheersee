require "test_helper"

class FriendMessageTest < ActiveSupport::TestCase

  def setup
    @friend_message = FriendMessage.new(friendship_id: 1, user_id: 1, content: "Hello")
  end

  test "friend message exist" do
  	assert @friend_message.valid?
  end

  test "validate friend message if friendship_id does not exist" do
  	@friend_message.friendship_id = "  "
  	assert_not @friend_message.valid?
  end

  test "validate friend message if user_id does not exist" do
  	@friend_message.user_id = "  "
  	assert_not @friend_message.valid?
  end

  test "validate friend message if content does not exist" do
  	@friend_message.content = "  "
  	assert_not @friend_message.valid?
  end
end
