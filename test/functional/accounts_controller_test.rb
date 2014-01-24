require 'test_helper'

class Merchant::AccountsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    #@controller = Merchant::AccountsController.new
    @account = accounts(:one)
    sign_in @user
  end

  test "should get index" do
      get :index
      assert_response :success
  end

  test "should get new" do
      get :new
      assert_response :success
  end

  test "should get edit" do
      get :edit, id: @account
      assert_response :success
  end

  test "should destroy an account" do
    assert_difference('Article.count', -1) do
      delete :destroy, id: @account
    end

    assert_redirected_to articles_path
  end

  test "should verify accounts" do
      get :verified_account
      assert_response :success
  end

  test "should add brands" do
  end
end
