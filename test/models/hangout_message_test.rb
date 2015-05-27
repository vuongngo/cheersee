require "test_helper"

class HangoutMessageTest < ActiveSupport::TestCase

  def setup
    @hangout_message = HangoutMessage.new(hangout_id: 1, user_id: 1, content: "Hello")
  end

  test "hangout message exist" do
  	assert @hangout_message.valid?
  end

  test "validate hangout message if hangout_id does not exist" do
  	@hangout_message.hangout_id = "  "
  	assert_not @hangout_message.valid?
  end	

  test "validate hangout message if user_id does not exist" do
  	@hangout_message.user_id = "  "
  	assert_not @hangout_message.valid?
  end	

  test "validate hangout message if content does not exist" do
  	@hangout_message.content = "  "
  	assert_not @hangout_message.valid?
  end	
end
