require "test_helper"

class GeneralNotificationCountTest < ActiveSupport::TestCase

  def general_notification_count
    @general_notification_count ||= GeneralNotificationCount.new
  end

  def test_valid
    assert general_notification_count.valid?
  end

end
