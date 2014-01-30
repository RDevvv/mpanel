require 'test_helper'

class Merchant::AdGroupsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should show ad group" do
    get :show, account_id: 1, account_brand_id: 1, ad_id:1, id:1
    assert_response :success
  end

  test "should delete outlet" do
    get :delete_outlet, account_id: 1, account_brand_id: 1, ad_id:1, id:1
    assert_response :success
  end

end
