require "test_helper"

class MessageNotificationTest < ActiveSupport::TestCase

  def setup
    @message_notification = MessageNotification.new(user_id: 1, unread_count: 1)
  end

  test "message notification exist" do
  	assert @message_notification.valid?
  end

  test "validate message notification if user_id does not exist" do
  	@message_notification.user_id = "  "
  	assert_not @message_notification.valid?
  end

  test "validate uniqueness of message notification" do
  	@message_notification.save!
  	@message_notification1 = MessageNotification.new(user_id: 1, unread_count: 9)
  	assert_not @message_notification1.valid?
  end
end
