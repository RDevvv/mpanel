require 'test_helper'

class Merchant::AccountsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    @account = accounts(:one)
    sign_in @user
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get :edit, id: 1
  #   assert_response :success
  # end

  # test "should create new account" do
  #   assert_difference('Account.count') do
  #     post :create, account: { address: @account.address, area_id: @account.area_id, registered_company_name: @account.registered_company_name }
  #   end
  # end

  # test "should update an account" do
  #   put :update, account: { address: @account.address, area_id: @account.area_id, registered_company_name: @account.registered_company_name }
  #   assert_redirected_to merchant_accounts_path
  # end

  # test "should destroy an account" do
  #   assert_difference('Account.count', -1) do
  #     delete :destroy, id: @account
  #   end

  #   assert_redirected_to accounts_path
  # end

  # test "should get show" do
  #   get :show, id: 1
  #   assert_response :success
  # end

  # test "should verify accounts" do
  #   get :verified_account, id: 1
  #   assert_response :success
  # end

  # test "should add brands" do
  #   post :add_brands, id:1
  #   assert_response :success
  # end

end