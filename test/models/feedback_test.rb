require "test_helper"

class FeedbackTest < ActiveSupport::TestCase

  def setup
    @feedback = Feedback.new(reference_id: 1, time_management_id: 1, rate: 80, friendly: 34, fun: 46, confidence: 35, curiosity: 46, comment: "Thank you")
  end

  test "feedback exist" do
  	assert @feedback.valid?
  end

  test "validate feedback if reference_id does not exist" do
  	@feedback.reference_id = "  "
  	assert_not @feedback.valid?
  end

  test "validate feedback if time_management_id does not exist" do
  	@feedback.time_management_id = "  "
  	assert_not @feedback.valid?
  end

  test "validate feedback if rate does not exist" do
  	@feedback.rate = "  "
  	assert_not @feedback.valid?
  end

  test "validate feedback if friendly does not exist" do
  	@feedback.friendly = "  "
  	assert_not @feedback.valid?
  end

  test "validate feedback if fun does not exist" do
  	@feedback.fun = "  "
  	assert_not @feedback.valid?
  end

  test "validate feedback if confidence does not exist" do
  	@feedback.confidence = "  "
  	assert_not @feedback.valid?
  end

  test "validate feedback if curiosity does not exist" do
  	@feedback.curiosity = "  "
  	assert_not @feedback.valid?
  end

  test "validate uniqueness of feedback" do
  	@feedback.save!
    @feedback1 = Feedback.new(reference_id: 1, time_management_id: 2, rate: 50, friendly: 24, fun: 46, confidence: 35, curiosity: 46, comment: "Thank you")
    assert_not @feedback1.valid?
  end
end
