require "test_helper"

class SetChallengeCommentTest < ActiveSupport::TestCase

  def setup
    @set_challenge_comment = SetChallengeComment.new(set_challenge_id: 1, user_id: 1, comment: "Hello")
  end

  test "set challenge comment exist" do
  	assert @set_challenge_comment.valid?
  end

  test "validate set challenge comment if set_challenge_id exist" do
  	@set_challenge_comment.set_challenge_id = "  "
  	assert_not @set_challenge_comment.valid?
  end

  test "validate set challenge comment if user_id exist" do
  	@set_challenge_comment.user_id = "  "
  	assert_not @set_challenge_comment.valid?
  end

  test "validate set challenge comment if comment exist" do
  	@set_challenge_comment.comment = "  "
  	assert_not @set_challenge_comment.valid?
  end

end
