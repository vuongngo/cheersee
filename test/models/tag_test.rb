require "test_helper"

class TagTest < ActiveSupport::TestCase

  def setup
    @tag = Tag.new(name: "coffee")
  end

  test "validate uniquess of tag" do
  	@tag.save!
  	@tag1 = Tag.new(name: "coffee")
  	assert_not @tag1.valid?
  end

end
