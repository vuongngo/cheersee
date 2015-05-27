require "test_helper"

class SetChallengeTest < ActiveSupport::TestCase

  def setup
    @set_challenge = SetChallenge.new(user_id: 1, post: "Soccer", time_span: 9, point_metric: "second", point_measure: "highest", longitude: 79.0797433, latitude: 73.797943, international: false, no_of_fav: 0)
  end

  test "set challenge exist" do
  	assert @set_challenge.valid?
  end

  test "validate uniqueness" do
  	@set_challenge.save!
    @set_challenge1 = SetChallenge.new(user_id: 1, post: "Soccer", time_span: 9, point_metric: "minute", point_measure: "lowest", longitude: 79.0797433, latitude: 73.797943, international: false)
    assert_not @set_challenge1.valid?
  end

  test "validate set challenge if user_id does not exist" do
  	@set_challenge.user_id = "  "
  	assert_not @set_challenge.valid?
  end

  test "validate set challenge if post does not exist" do
  	@set_challenge.post = "  "
  	assert_not @set_challenge.valid?
  end

  test "validate set challenge if time_span does not exist" do
  	@set_challenge.time_span = "  "
  	assert_not @set_challenge.valid?
  end

  test "validate set challenge if time_span is not number" do
  	@set_challenge.time_span = "one day"
  	assert_not @set_challenge.valid?
  end

  test "validate set challenge if point_metric does not exist" do
  	@set_challenge.point_metric = "  "
  	assert_not @set_challenge.valid?
  end

  test "validate set challenge if point_measure does not exist" do
  	@set_challenge.point_measure = "  "
  	assert_not @set_challenge.valid?
  end

  test "validate set challenge if longitude does not exist" do
  	@set_challenge.longitude = "  "
  	assert_not @set_challenge.valid?
  end

  test "validate set challenge if latitude does not exist" do
  	@set_challenge.latitude = "  "
  	assert_not @set_challenge.valid?
  end

  test "validate set challenge if no_of_fav does not exist" do
    @set_challenge.no_of_fav = "  "
    assert_not @set_challenge.valid?
  end
end
