require 'test_helper'

class Merchant::AccountsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @account = accounts(:one)
  end

  test "should get index" do
      get :index
      assert_response :success
  end

 # test "should get new" do
 #     get :new
 #     assert_response :success
 # end

 # test "should get edit" do
 #     get :edit, id: @account
 #     assert_response :success
 # end

 # test "should destroy an account" do
 #   assert_difference('Account.count', -1) do
 #     delete :destroy, id: @account
 #   end

 #   assert_redirected_to accounts_path
 # end

 # test "should verify accounts" do
 #     get :verified_account, id: 1
 #     assert_response :success
 # end

 # test "should add brands" do
 # end
end
