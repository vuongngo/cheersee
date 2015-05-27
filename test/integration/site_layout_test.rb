require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do 
  	get root_path
  	assert_template 'static_pages/home'
  	assert_template 'static_pages/_intro'
  	assert_template 'devise/shared/_links'
  	assert_template 'devise/registrations/_new'
  	assert_template 'devise/sessions/_new'
  	assert_template 'layouts/_header'
  	assert_template 'layouts/application'
  end
end
