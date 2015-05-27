require "test_helper"

class LocationTest < ActiveSupport::TestCase

  def setup
    @location = Location.new(user_id: 1, longitude: 47.78643894, latitude: 74.797973)
  end

  test "user location exist" do
  	assert @location.valid?
  end

  test "validate uniqueness of user location" do
  	@location.save!
  	@location1 = Location.new(user_id: 1)
 	assert_not @location1.valid?
  end
end
