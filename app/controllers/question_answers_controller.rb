class QuestionAnswersController < ApplicationController

	def index
	  @question_answers = QuestionAnswer.all
	end
end
