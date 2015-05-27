require "test_helper"

class HangoutTest < ActiveSupport::TestCase

  def setup
    @hangout = Hangout.new(business_name: "coffee bean", business_location: "24 High Street", longitude: 23.545423, latitude: 23.545453, share_time: "2014-11-11 00:00:00")
  end

  test "hangout exist" do
  	assert @hangout.valid?
  end

  test "validate hangout if longitude does not exist" do
  	@hangout.longitude = "  "
  	assert_not @hangout.valid?
  end

  test "validate hangout if latitude does not exist" do
  	@hangout.latitude = "  "
  	assert_not @hangout.valid?
  end

  test "validate hangout if share_time does not exist" do
  	@hangout.share_time = "  "
  	assert_not @hangout.valid?
  end

end
