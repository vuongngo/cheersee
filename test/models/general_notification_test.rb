require "test_helper"

class GeneralNotificationTest < ActiveSupport::TestCase

  def setup
    @general_notification = GeneralNotification.new(user_id: 1, mes: "X sent you a hangout request!")
  end

  test "general notification exist" do
  	assert @general_notification.valid?
  end

  test "validate general notification if user_id does not exist" do
  	@general_notification.user_id = "  "
  	assert_not @general_notification.valid?
  end

  test "validate general notification if mes does not exist" do
  	@general_notification.mes = "  "
  	assert_not @general_notification.valid?
  end

end
