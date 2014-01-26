require 'test_helper'

class Merchant::AccountBrandsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
        @user = users(:one)
        @account_brand = account_brands(:one)
        sign_in @user
    end

    test "should get index" do
        get :index, account_id: 1
        assert_response :success
    end

    test "should successfully add brands" do
        get :add_brands, account_id: 1, brand_ids: [1,2]
        assert_redirected_to merchant_account_account_brands_path
    end

    test "should show an account_brand" do
        get :show, account_id: 1, id: 1
    end

    test "should destroy an account_brand" do
        assert_difference('AccountBrand.count', -1) do
            delete :destroy, id: @account_brand, account_id: 1
        end

    end
end
