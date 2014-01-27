require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @account = accounts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account" do
    assert_difference('Account.count') do
      post :create, account: { account_balance: @account.account_balance, registered_company_name: @account.registered_company_name, account_key: @account.account_kay, address: @account.address, owner_id: @account.owner_id, area_id: @account.area_id, currency_id: @account.currency_id, is_active: @account.is_active, is_deleted: @account.is_deleted, is_verified: @account.is_verified, payment_status: @account.payment_status, users_attributes: @account.users_attributes, deleted_at: @account.deleted_at }
    end

    assert_redirected_to account_path(assigns(:account))
  end

  test "should show account" do
    get :show, id: @account
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @account
    assert_response :success
  end

  test "should update account" do
    put :update, id: @account, account: { account_balance: @account.account_balance, registered_company_name: @account.registered_company_name, account_key: @account.account_kay, address: @account.address, owner_id: @account.owner_id, area_id: @account.area_id, currency_id: @account.currency_id, is_active: @account.is_active, is_deleted: @account.is_deleted, is_verified: @account.is_verified, payment_status: @account.payment_status, users_attributes: @account.users_attributes, deleted_at: @account.deleted_at }
    assert_redirected_to account_path(assigns(:account))
  end

  test "should destroy an account" do
    assert_difference('Account.count', -1) do
      delete :destroy, id: @account
    end

    assert_redirected_to accounts_path
  end
end
