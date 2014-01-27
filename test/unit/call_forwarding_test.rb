require 'test_helper'

class CallForwardingTest < ActiveSupport::TestCase
    test "should get customer id" do
        CallForwarding.first.get_customer_id
        assert_equal Customer.first.id, CallForwarding.first.customer_id
    end

    test "should compare call forwarding number with exotel" do
        #CallForwarding.compare_call_forwarding_number_with_exotel
    end
end
