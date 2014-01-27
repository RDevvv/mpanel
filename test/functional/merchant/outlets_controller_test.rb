require 'test_helper'

class OutletsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @outlet = outlets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:outlets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create outlet" do
    assert_difference('Outlet.count') do
      post :create, outlet: { account_brand_id: @outlet.account_brand_id, address: @outlet.address, area_id: @outlet.area_id, email_id: @outlet.email_id, is_active: @outlet.is_active, is_verified: @outlet.is_verified, shop_no: @outlet.shop_no, latitude: @outlet.latitude, longitude: @outlet.longitude, mobile_number: @outlet.mobile_number, outlet_key: @outlet.outlet_key, phone_number: @outlet.phone_number, deleted_at: @outlet.deleted_at}
    end

    assert_redirected_to outlet_path(assigns(:outlet))
  end

  test "should show outlet" do
    get :show, id: @outlet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @outlet
    assert_response :success
  end

  test "should update outlet" do
    put :update, id: @outlet, outlet: { account_brand_id: @outlet.account_brand_id, address: @outlet.address, area_id: @outlet.area_id, email_id: @outlet.email_id, is_active: @outlet.is_active, is_verified: @outlet.is_verified, shop_no: @outlet.shop_no, latitude: @outlet.latitude, longitude: @outlet.longitude, mobile_number: @outlet.mobile_number, outlet_key: @outlet.outlet_key, phone_number: @outlet.phone_number, deleted_at: @outlet.deleted_at }
    assert_redirected_to outlet_path(assigns(:outlet))
  end

  test "should destroy an outlet" do
    assert_difference('Outlet.count', -1) do
      delete :destroy, id: @outlet
    end

    assert_redirected_to outlets_path
  end

end
