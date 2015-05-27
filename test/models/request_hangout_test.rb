require "test_helper"

class RequestHangoutTest < ActiveSupport::TestCase

  def setup
    @request_hangout = RequestHangout.new(user_id: 1, share_hangout_id: 1, mes: "Hello")
  end

  test "request hangout exist" do 
  	assert @request_hangout.valid?
  end

  test "validate request hangout if user_id does not exist" do
  	@request_hangout.user_id = "  "
  	assert_not @request_hangout.valid?
  end

  test "validate request hangout if share_hangout_id does not exist" do
  	@request_hangout.share_hangout_id = "  "
  	assert_not @request_hangout.valid?
  end

  test "validate request hangout if mes does not exist" do
  	@request_hangout.mes = "  "
  	assert_not @request_hangout.valid?
  end

  test "validate accept false initially" do
  	assert @request_hangout.accept == false
  end
  
  test "validate uniqueness of request hangout" do
  	@request_hangout.save!
    @request_hangout1 = RequestHangout.new(user_id: 1, share_hangout_id: 1, mes: "Hi")
 	assert_not @request_hangout1.valid?
 end	

end
