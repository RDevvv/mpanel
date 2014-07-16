require 'test_helper'

class Merchant::AdsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
        @user = users(:one)
        sign_in @user
        @ad = ads(:one)
    end

    test "should get index" do
        get :index, account_id: 1, account_brand_id: 1
        assert_response :success
    end

    test "should get new" do
        get :new, account_id: 1, account_brand_id: 1
        assert_response :success
    end

    test "should toggle active" do
        get :toggle_active, id: @ad, account_id: 1, account_brand_id: 1
        # assert_response :success
        assert_redirected_to merchant_account_account_brand_ads_path
    end

    test "should toggle exclusive" do
        get :toggle_exclusive, id: @ad, account_id: 1, account_brand_id: 1
        assert_redirected_to merchant_account_account_brand_ads_path
    end

    test "should show ad" do
        get :show, id: @ad, account_id: 1, account_brand_id: 1
        assert_response :success
    end

   # test "should get edit" do
   #     get :edit, id: @ad, account_id: 1, account_brand_id: 1
   #     assert_response :success
   # end

    test "should create new ad" do
        post :create, account_id: 1, account_brand_id: 1, id: @ad, ad: { ad_title: @ad.ad_title, start_date: @ad.start_date, expiry_date: @ad.expiry_date, sms_text: @ad.sms_text}
    end

    test "should update ad" do
        post :update, account_id: 1, account_brand_id: 1, id: @ad, ad: { ad_title: @ad.ad_title, start_date: @ad.start_date, expiry_date: @ad.expiry_date, sms_text: @ad.sms_text}
        assert_redirected_to merchant_account_account_brand_ad_path
    end

    test "should destroy ad" do
        assert_difference('Ad.count', -1) do
            delete :destroy, account_id: 1, account_brand_id: 1, id: @ad
        end

        assert_redirected_to merchant_account_account_brand_ads_path
    end
end
