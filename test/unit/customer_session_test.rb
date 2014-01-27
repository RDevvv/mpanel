require 'test_helper'

class CustomerSessionTest < ActiveSupport::TestCase
    test "if gecoding function returns address" do
        address = CustomerSession.first.geocoding_address
        assert_equal "india", address
    end
end
