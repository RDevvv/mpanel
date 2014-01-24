require 'test_helper'

class Merchant::BrandsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
        @user = users(:one)
        sign_in @user
        @brand= brands(:one)
    end

    test "should get index" do
        get :index
        assert_response :success
    end

    test "should get new" do
        get :new
        assert_redirected_to new_merchant_accounts_path:w
    end
end
