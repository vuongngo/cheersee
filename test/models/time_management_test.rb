require "test_helper"

class TimeManagementTest < ActiveSupport::TestCase

  def setup
    @time_management = TimeManagement.new(manage: "Early")
  end

  test "time management exist" do
  	assert @time_management.valid?
  end

  test "time management validate presence of" do
  	@time_management.manage = "  "
  	assert_not @time_management.valid?
  end

  test "time management validate unique" do
  	@time_management.save!
  	@time_management1 = TimeManagement.new(manage: "Early")
  	assert_not @time_management1.valid?
  end

end
