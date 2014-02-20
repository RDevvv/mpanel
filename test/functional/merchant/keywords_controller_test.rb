require 'test_helper'

class Merchant::KeywordsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
  setup do
    @user = users(:one)
    sign_in @user
    @keyword = keywords(:one)
  end

  test "should get new" do
    get :new, account_id: 1, account_brand_id: 1
    assert_response :success
  end

  test "should create new keyword" do
    post :create, account_id: 1, account_brand_id: 1, id: @keyword, keyword: { keyword: @keyword.keyword, keyword_alias:@keyword.keyword_alias }
  end
end
