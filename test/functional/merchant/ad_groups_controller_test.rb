require 'test_helper'

class Merchant::AdGroupsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @ad_group = ad_groups(:one)
  end

  test "should show ad group" do
    get :show, account_id: 1, account_brand_id: 1, ad_id:1, id:1
    assert_response :success
  end

  test "should delete outlet" do
    get :delete_outlet, account_id: 1, account_brand_id: 1, ad_id:1, outlet_id:1, id:1
  #  assert_response :success
  end

  test "should add more promocodes" do
    get :more_promocodes, account_id: 1, account_brand_id: 1, ad_id:1, id:1
      assert_response :success
  end

  test "should add more outlets" do
    get :more_outlets, account_id: 1, account_brand_id: 1, ad_id:1, id:1
      assert_response :success
  end

  test "should add more promocodes to existing group" do
    get :add_more_promocodes, account_id: 1, account_brand_id: 1, ad_id:1, id:1, ad_promocode: {promocode: "test promocode", cap: 1, outlet_ids: [1,2], set_name: @ad_group.name}
  #    assert_response :success
  end

  test "should add more outlets to existing group" do
    get :add_more_outlets, account_id: 1, account_brand_id: 1, ad_id:1, outlet_ids: [1,2], id:1
  #    assert_response :success
  end

  test "should destroy a group" do
    delete :destroy, account_id: 1, account_brand_id: 1, ad_id:1, id: @ad_group
  end

end
