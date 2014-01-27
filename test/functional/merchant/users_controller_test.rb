require 'test_helper'

class Merchant::UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

 # test "should get new" do
#    get :new
#    assert_response :success
#  end

#  test "should create user" do
#    assert_difference('User.count') do
 #     post :create, user: { first_name: @user.first_name, last_name: @user.last_name, mobile_number: @user.mobile_number, user_key: @user.user_key, is_active: @user.is_active, email_verified: @user.email_verified, mobile_verified: @user.mobile_verified, email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation, remember_me: @user.remember_me, subscribe_email_updates: @user.subscribe_email_updates, subscribe_crm_updates: @user.subscribe_crm_updates }
 #   end

#    assert_redirected_to user_path(assigns(:user))
#  end

#  test "should get edit" do
#    get :edit, id: @user
#    assert_response :success
#  end

#  test "should update user" do
#    put :update, id: @user, user: { first_name: @user.first_name, last_name: @user.last_name, mobile_number: @user.mobile_number, user_key: @user.user_key, is_active: @user.is_active, email_verified: @user.email_verified, mobile_verified: @user.mobile_verified, email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation, remember_me: @user.remember_me, subscribe_email_updates: @user.subscribe_email_updates, subscribe_crm_updates: @user.subscribe_crm_updates }
#    assert_redirected_to user_path(assigns(:user))
#  end

#  test "should destroy an user" do
#   assert_difference('User.count', -1) do
#      delete :destroy, id: @user
#    end

#    assert_redirected_to users_path
#  end
end
