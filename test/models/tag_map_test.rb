require "test_helper"

class TagMapTest < ActiveSupport::TestCase

  def setup
    @tag_map = TagMap.new(user_id: 1, tag_id: 1)
  end

  test "validate tagmap exist" do
   assert @tag_map.valid?
  end

  test "validate tagmap when user_id does not exist" do
  	@tag_map.user_id = "  "
  	assert_not @tag_map.valid?
  end 

  test "validate tagmap when tag_id does not exist" do
  	@tag_map.tag_id = "  "
  	assert_not @tag_map.valid?
  end

  test "validate uniqueness of tagmag" do
  	@tag_map.save!
  	@tag_map1 = TagMap.new(user_id: 1, tag_id: 1)
  	assert_not @tag_map1.valid?
  end
end
