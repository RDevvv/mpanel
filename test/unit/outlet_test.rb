require 'test_helper'

class OutletTest < ActiveSupport::TestCase
    test "should activate an outlet" do
       # Outlet.first.update_attributes(:is_active => false)
       # Outlet.first.activate
       # assert_equal true, Outlet.first.is_active
    end

    test "should deactivate an outlet" do
        Outlet.first.update_attributes(:is_active => true)
        Outlet.first.deactivate
        assert_equal false, Outlet.first.is_active
    end

    test "should check the output of if_address_changed when address is not changed" do
        change = Outlet.first.is_address_changed?
        assert_equal false, change
    end

    test "should check the output of if_address_changed when address is changed" do
        Outlet.first.update_attributes(:address => SecureRandom.hex)
        puts Outlet.first.address
        change = Outlet.first.is_address_changed?
        assert_equal true, change
    end
end
