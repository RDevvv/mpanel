require 'test_helper'

class Merchant::AdPromocodesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @ad_promocode = ad_promocodes(:one)
    @ad_group = ad_groups(:one)
  end

  test "should get index" do
    get :index, account_id: 1, account_brand_id: 1, ad_id: 1
    assert_response :success
  end

  test "should get new" do
    get :new, account_id: 1, account_brand_id: 1, ad_id: 1
    assert_response :success
  end

  test "should get edit" do
    get :edit, account_id: 1, account_brand_id: 1, ad_id: 1, id: 1
    assert_response :success
  end

  test "should add single invalid promocode" do
    #get :add_single_code, account_id: 1, account_brand_id: 1, ad_id: 1, ad_promocode: {cap: 1, outlet_ids: [1,2], set_name: @ad_group.name}
    #assert_response :success
  end

  test "should add single valid promocode" do
    get :add_single_code, account_id: 1, account_brand_id: 1, ad_id: 1, ad_promocode: {promocode: "test promocode", cap: 1, outlet_ids: [1,2], set_name: @ad_group.name}
    assert_response :success
  end

  test "should add multiple promocodes" do
    get :add_multiple_code, account_id: 1, account_brand_id: 1, ad_id: 1, ad_promocode: {promocodes: "vivek, varade", outlet_ids: [1,2], set_name: @ad_group.name}
    assert_response :success
  end

  test "should get show" do
    get :show, account_id: 1, account_brand_id: 1, ad_id: 1, id: 1
  end

  test "should destroy an ad_promocode" do
    assert_difference('AdPromocode.count', -1) do
      delete :destroy, id: @ad_promocode, account_id: 1, account_brand_id: 1, ad_id: 1
    end
  end

end
