require "test_helper"

class WhoHangoutTest < ActiveSupport::TestCase

  def setup
    @who_hangout = WhoHangout.new(hangout_id: 1, user_id: 1)
  end

  test "who hangout exist" do 
  	assert @who_hangout.valid?
  end

  test "who_hangout fails when user doesn't exist" do
  	@who_hangout.user_id = nil
  	assert_not @who_hangout.valid?
  end

  test "who_hangout fails when hangout doesnt' exist" do
  	@who_hangout.hangout_id = nil
  	assert_not @who_hangout.valid?
  end

  test "who_hangout fails when user_id is not number" do
    @who_hangout.user_id = "Hello"
    assert_not @who_hangout.valid?
  end

  test "who_hangout fails when hangout_id is not number" do
    @who_hangout.hangout_id = "Hello"
    assert_not @who_hangout.valid?
  end

  test "who_hangout fails when hangout_id and user_id is not unique" do
  	@who_hangout.save!
    @who_hangout2 = WhoHangout.new(hangout_id: 1, user_id: 1)
    assert_not @who_hangout2.valid?
  end
end
