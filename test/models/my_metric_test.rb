require "test_helper"

class MyMetricTest < ActiveSupport::TestCase

  def my_metric
    @my_metric ||= MyMetric.new
  end

  def test_valid
    assert my_metric.valid?
  end

end
