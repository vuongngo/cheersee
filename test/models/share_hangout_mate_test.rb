require "test_helper"

class ShareHangoutMateTest < ActiveSupport::TestCase

  def share_hangout_mate
    @share_hangout_mate ||= ShareHangoutMate.new
  end

  def test_valid
    assert share_hangout_mate.valid?
  end

end
