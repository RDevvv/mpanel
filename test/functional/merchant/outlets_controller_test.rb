require 'test_helper'

class Merchant::OutletsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    @outlet = outlets(:one)
    sign_in @user
  end

  test "should get index" do
    get :index, account_id: 1, account_brand_id: 1
    assert_response :success
  end

  test "should get new" do
    get :new, account_id: 1, account_brand_id: 1
    assert_response :success
  end

#  test "should create outlet" do
#    assert_difference('Outlet.count') do
#      post :create, account_id: 1, outlet: { account_brand_id: @outlet.account_brand_id, address: @outlet.address, area_id: @outlet.area_id, email_id: @outlet.email_id, shop_no: @outlet.shop_no, latitude: @outlet.latitude, longitude: @outlet.longitude, mobile_number: @outlet.mobile_number, outlet_key: @outlet.outlet_key, phone_number: @outlet.phone_number }
#    end
#  end

  test "should show outlet" do
    get :show, id: @outlet, account_id: 1, account_brand_id: 1, id: 1
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @outlet, account_id: 1, account_brand_id: 1, id: 1
    assert_response :success
  end

  test "should update outlet" do
    # put :update,  account_id: 1, account_brand_id: 1, id: @outlet, outlet: { address: @outlet.address, area_id: @outlet.area_id, email_id: @outlet.email_id, is_active: @outlet.is_active, is_verified: @outlet.is_verified, shop_no: @outlet.shop_no, latitude: @outlet.latitude, longitude: @outlet.longitude, mobile_number: @outlet.mobile_number, outlet_key: @outlet.outlet_key, phone_number: @outlet.phone_number, deleted_at: @outlet.deleted_at }
    # assert_redirected_to merchant_account_account_brand_path
  end

  test "should create new outlet" do
    # post :create, account_id: 1, account_brand_id: 1, id: @outlet, area:{ city_id: 64, area_name:"santacruz east",pincode:"400055 "}, outlet: { address: @outlet.address, area_id: @outlet.area_id, email_id: @outlet.email_id, is_active: @outlet.is_active, is_verified: @outlet.is_verified, shop_no: @outlet.shop_no, latitude: @outlet.latitude, longitude: @outlet.longitude, mobile_number: @outlet.mobile_number, outlet_key: @outlet.outlet_key, phone_number: @outlet.phone_number, deleted_at: @outlet.deleted_at }
    # assert_redirected_to merchant_account_account_brand_path
  end

  test "should destroy an outlet" do
    assert_difference('Outlet.count', -1) do
      delete :destroy, id: @outlet, account_id: 1, account_brand_id: 1
    end
  end

  # test "show imported csv records" do
  #   get :import, account_id: 1, account_brand_id: 1
  #   assert_response :success
  # end

  test "should toggle active" do
    get :toggle_active, id: @outlet, account_id: 1, account_brand_id: 1
    assert_redirected_to merchant_account_account_brand_path
  end

 # test "should toggle verify" do
 #   post :toggle_verify, id: @outlet, account_id: 1, account_brand_id: 1
 #   assert_redirected_to merchant_account_account_brand_ad_ad_group_path
 # end

  test "should toggle active index" do
    # get :toggle_active_index, id: @outlet, account_id: 1, account_brand_id: 1
    # assert_redirected_to merchant_account_account_brand_outlets_path
  end
end
