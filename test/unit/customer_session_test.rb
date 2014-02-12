require 'test_helper'

class CustomerSessionTest < ActiveSupport::TestCase
    test "if gecoding function returns address" do
        address = CustomerSession.first.geocoding_address
        assert_equal "india", address
    end

    test "if update_coordinates is functioning for blank customer field" do
        location = Hash.new
        location[:latitude] = 17.123
        location[:longitude] = 72.123
        customer_uuid = SecureRandom.uuid unless Customer.exists?(:uuid => SecureRandom.uuid)
        count_before_current_session = CustomerSession.count
        CustomerSession.update_coordinates(customer_uuid,location)
        count_after_current_session = CustomerSession.count
        assert_equal count_after_current_session,  count_before_current_session+1
    end

    test "if update_coordinates is functioning for existing customer having no sessions" do
        location = Hash.new
        location[:latitude] = 17.123
        location[:longitude] = 72.123
        customer_uuid = Customer.find(2).uuid
        count_before_current_session = CustomerSession.count
        CustomerSession.update_coordinates(customer_uuid,location)
        count_after_current_session = CustomerSession.count
        assert_equal count_after_current_session,  count_before_current_session+1
    end

    test "if update_coordinates is functioning for existing customer having sessions" do
        location = Hash.new
        location[:latitude] = 17.123
        location[:longitude] = 72.123
        customer_uuid = Customer.find(1).uuid
        CustomerSession.update_coordinates(customer_uuid,location)
        assert_equal Customer.find(1).customer_sessions.last.latitude, location[:latitude]
    end
end
