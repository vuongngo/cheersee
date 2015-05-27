require "test_helper"

class ContactMeTest < ActiveSupport::TestCase

  def setup
    @contact_me = ContactMe.new(user_id: 1, question: "What is that?")
  end

  test "contact me exist" do
  	assert @contact_me.valid?
  end

  test "validates contact me if user_id does not exist" do
  	@contact_me.user_id = "  "
  	assert_not @contact_me.valid?
  end

  test "validates contact me if question does not exist" do
  	@contact_me.question = "  "
  	assert_not @contact_me.valid?
  end
end
