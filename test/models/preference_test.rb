require "test_helper"

class PreferenceTest < ActiveSupport::TestCase

  def preference
    @preference ||= Preference.new
  end

  def test_valid
    assert preference.valid?
  end

end
