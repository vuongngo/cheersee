class ContactMailer < ActionMailer::Base
  default to: "hello@cheersee.co"

  def ask_question(user, question)
  	@user = user
  	@question = question
  	mail(from: @user.email, subject: 'New question from user!')
  end
end
