require "test_helper"

class JoinChallengeCommentTest < ActiveSupport::TestCase

  def setup
    @join_challenge_comment = JoinChallengeComment.new(join_challenge_id: 1, user_id: 1, comment: "hey")
  end

  test "join challenge comment exist" do
  	assert @join_challenge_comment.valid?
  end

  test "validate join challenge comment if join_challenge_id does not exist" do
  	@join_challenge_comment.join_challenge_id = "  "
  	assert_not @join_challenge_comment.valid?
  end

  test "validate join challenge comment if user_id does not exist" do
  	@join_challenge_comment.user_id = "  "
  	assert_not @join_challenge_comment.valid?
  end

  test "validate join challenge comment if comment does not exist" do
  	@join_challenge_comment.comment = "  "
  	assert_not @join_challenge_comment.valid?
  end
end
