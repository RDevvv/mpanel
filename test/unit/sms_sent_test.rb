require 'test_helper'

class SmsSentTest < ActiveSupport::TestCase
    test "should track the usage of promocodes" do
        SmsSent.find(1).track_usage
        assert_equal 1, Ad.find(1).usage
    end

    test "should get customer number" do
        number = SmsSent.find(1).get_number
        assert_equal number, SmsSent.find(1).customer.mobile_number
    end
end
