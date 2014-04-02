require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
        @user = users(:one)
        sign_in @user
        @customer = customers(:one)
    end

    test "should get mobile number" do
    end
end
