require 'test_helper'

class AreaTest < ActiveSupport::TestCase
    test "should get area address" do
        address = Area.first.area_address
        assert_equal "nerul, Mumbai", address
    end

    test "if address is not changed" do
        is_address_changed = Area.first.address_changed?
        assert_equal false, is_address_changed
    end

    test "if address is changed" do
        Area.first.update_attributes(:area_name => SecureRandom.hex(4))
        is_address_changed = Area.first.address_changed?
        assert_equal false, is_address_changed
    end

    test "should get country" do
        country= Area.first.country
        assert_equal Country.first, country
    end
end
