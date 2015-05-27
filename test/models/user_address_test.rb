require "test_helper"

class UserAddressTest < ActiveSupport::TestCase

  def user_address
    @user_address ||= UserAddress.new
  end

  def test_valid
    assert user_address.valid?
  end

end
