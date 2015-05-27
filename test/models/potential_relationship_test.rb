require "test_helper"

class PotentialRelationshipTest < ActiveSupport::TestCase

  def potential_relationship
    @potential_relationship ||= PotentialRelationship.new
  end

  def test_valid
    assert potential_relationship.valid?
  end

end
