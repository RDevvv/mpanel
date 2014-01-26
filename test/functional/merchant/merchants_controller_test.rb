require 'test_helper'

class Merchant::MerchantsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
        @user = users(:one)
        sign_in @user
    end

    test "should get index" do
        get :index
        assert_response :success
    end
end
