require "test_helper"

class ReputationTest < ActiveSupport::TestCase

  def setup
    @reputation = Reputation.new(user_id: 1, time_early: 2, time_late: 4, never_come: 1, rate_av: 67, friendly_av: 54, fun_av: 34, confidence_av: 54, curiosity_av: 67, number_of_rate: 7)
  end

  test "reputation exist" do 
  	assert @reputation.valid?
  end

  test "validate reputation if rate_av in range" do
  	@reputation.rate_av = 104
  	assert_not @reputation.valid?
  end

  test "validate uniqueness of reputation" do
  	@reputation.save!
    @reputation1 = Reputation.new(user_id: 1, time_early: 5, time_late: 4, never_come: 1, rate_av: 67, friendly_av: 54, fun_av: 34, confidence_av: 54, curiosity_av: 67, number_of_rate: 7)
    assert_not @reputation1.valid?
  end

end
