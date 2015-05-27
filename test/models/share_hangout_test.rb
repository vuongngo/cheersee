require 'test_helper'

class ShareHangoutTest < ActiveSupport::TestCase

  def setup
  	@share_hangout = ShareHangout.new(content: "Cafe anyone?", user_id: 1, share_time: "2014-11-11 00:00:00 +1100", business_location: "23 High Street, Vic", longitude: 20.979434, latitude: 34.9797433, business_name: "Coffee Bean", notify_friend: true, open_nearby: true)
  end

  test "share hangout exist" do
    assert @share_hangout.valid?
  end

  test "validate share hangout if content does not exist" do
    @share_hangout.content = "  "
    assert_not @share_hangout.valid?
  end

  test "validate share hangout if user_id does not exist" do
  	@share_hangout.user_id = "  "
  	assert_not @share_hangout.valid?
  end

  test "validate share hangout if share_time does not exist" do
  	@share_hangout.share_time = "  "
  	assert_not @share_hangout.valid?
  end

  # test "validate share hangout if share_time is earlier than current time" do
  # 	@share_hangout.share_time = time.zone.now - 1.hour
  # 	assert_not @share_hangout.valid?
  # end

  test "validate share hangout if longitude does not exist" do
  	@share_hangout.longitude = "  "
  	assert_not @share_hangout.valid?
  end

  test "validate share hangout if latitude does not exist" do
  	@share_hangout.latitude = "  "
  	assert_not @share_hangout.valid?
  end

  test "validate share hangout if notify_friend does not exist" do
  	@share_hangout.notify_friend = "  "
  	assert_not @share_hangout.valid?
  end

  test "validate share hangout if open_nearby does not exist" do
  	@share_hangout.open_nearby = "  "
  	assert_not @share_hangout.valid?
  end

  test "validate share hangout uniqueness" do
  	@share_hangout.save!
  	@share_hangout1 = ShareHangout.new(content: "Cafe anybody?", user_id: 1, share_time: "2014-11-11 00:00:00 +1100", business_location: "23 High Street, Vic", longitude: 20.979434, latitude: 34.9797433, business_name: "Coffee Bean", notify_friend: false, open_nearby: false)
  	assert_not @share_hangout1.valid?
  end

end