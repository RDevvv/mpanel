require 'test_helper'

class SmsSentTest < ActiveSupport::TestCase
    test "should track the usage of promocodes" do
        SmsSent.first.track_usage
        assert_equal 1, Ad.first.usage
    end
end
