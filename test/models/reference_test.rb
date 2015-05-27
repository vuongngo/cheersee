require "test_helper"

class ReferenceTest < ActiveSupport::TestCase

  def setup
    @reference = Reference.new(user_id: 1, receiver_id: 2, hangout_id: 1)
  end

  test "reference exist" do 
  	assert @reference.valid?
  end

  test "validate reference if user_id does not exist" do
  	@reference.user_id = "  "
  	assert_not @reference.valid?
  end

  test "validate reference if receiver_id does not exist" do
  	@reference.receiver_id = "  "
  	assert_not @reference.valid?
  end

  test "validate reference if hangout_id does not exist" do
  	@reference.hangout_id = "  "
  	assert_not @reference.valid?
  end

  test "validate reference with feed false initially" do
  	assert_not @reference.feed == true
  end

  test "validate uniqueness of reference" do
  	@reference.save!
    @reference1 = Reference.new(user_id: 1, receiver_id: 2, hangout_id: 1)
    assert_not @reference1.valid?
  end

end
