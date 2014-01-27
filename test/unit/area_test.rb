require 'test_helper'

class AreaTest < ActiveSupport::TestCase
    test "should get area address" do
        address = Area.first.area_address
        assert_equal "nerul, Mumbai", address
    end

    test "should get country" do
        country= Area.first.country
        assert_equal Country.first, country
    end
end
