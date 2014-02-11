require 'test_helper'

class CallForwardingTest < ActiveSupport::TestCase
    test "should get customer id" do
        CallForwarding.first.get_customer_id
        assert_equal Customer.first.id, CallForwarding.first.customer_id
    end
end
