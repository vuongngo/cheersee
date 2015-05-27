require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  def setup
  	@user = User.new(email: "tuiqwe@gmail.com", password: "21143435", confirmed_at: "2014-11-11 00:00:00")
  end

  test "should get home" do
    get :home
    assert_response :success
    assert_template :home
    assert_template layout: "layouts/application"
    assert_template layout: "layouts/friendlist"
    assert_template layout: "layouts/dropdown"
    assert_template layout: "static_pages/intro"    
    assert_select "title", "Welcome !"
    assert_select "a", "Sign-in"
  end

  test "should redirect to home when user sign in" do
  	get :home
  	sign_in @user do
  	assert_redirect_to :home
  	assert_response :success
  	assert_template :home
  	assert_template layout: ""
  	assert_select "label", "MENU"
  	assert_select "input", "term" 
  	assert_select "a", "Post Achievement"
  	assert_select "a", "Friend's status"
  	end
  end


end