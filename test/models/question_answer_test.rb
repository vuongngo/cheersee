require "test_helper"

class QuestionAnswerTest < ActiveSupport::TestCase

  def setup
    @question_answer = QuestionAnswer.new(question: "How are you", answer: "Good thanks")
  end

  test "question and answer exist" do 
  	assert @question_answer.valid?
  end

end
