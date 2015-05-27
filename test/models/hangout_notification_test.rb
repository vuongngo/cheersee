require "test_helper"

class HangoutNotificationTest < ActiveSupport::TestCase

  def setup
    @hangout_notification = HangoutNotification.new(user_id: 1, unread_count: 2)
  end

  test "hangout notification exist" do
  	assert @hangout_notification.valid?
  end

  test "validate uniqueness of hangout_notification" do
  	@hangout_notification.save!
  	@hangout_notification1 = HangoutNotification.new(user_id: 1, unread_count: 4)
  	assert_not @hangout_notification1.valid?
  end

end
