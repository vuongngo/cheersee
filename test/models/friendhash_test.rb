require "test_helper"

class FriendhashTest < ActiveSupport::TestCase

  def setup
    @friendhash = Friendhash.new(user_id: 1, token: "Cookhih", limit_no: "3", lat: 45.7979434, lng: 54.3434242)
  end

  test "friendhash exist" do
  	assert @friendhash.valid?
  end

  test "validate friendhash if user_id does not exist" do
  	@friendhash.user_id = "  "
  	assert_not @friendhash.valid?
  end

  test "validate friendhash if token does not exist" do
  	@friendhash.token = "  "
  	assert_not @friendhash.valid?
  end

  test "validate friendhash if limit_no does not exist" do
  	@friendhash.limit_no = "  "
  	assert_not @friendhash.valid?
  end

  test "validate friendhash if lat does not exist" do
  	@friendhash.lat = "  "
  	assert_not @friendhash.valid?
  end

  test "validate friendhash if lng does not exist" do
  	@friendhash.lng = "  "
  	assert_not @friendhash.valid?
  end

  test "validate uniqueness of friendhash" do
  	@friendhash.save!
    @friendhash1 = Friendhash.new(user_id: 1, token: "Cookhih", limit_no: "3", lat: 45.7979434, lng: 54.3434242)
    assert_not @friendhash1.valid?
  end
end
