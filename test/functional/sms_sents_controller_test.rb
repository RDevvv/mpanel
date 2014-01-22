require 'test_helper'

class SmsSentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @sms_sent = sms_sents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sms_sents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sms_sent" do
    assert_difference('SmsSent.count') do
      post :create, sms_sent: { text: @sms_sent.text }
    end

    assert_redirected_to sms_sent_path(assigns(:sms_sent))
  end

  test "should show sms_sent" do
    get :show, id: @sms_sent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sms_sent
    assert_response :success
  end

  test "should update sms_sent" do
    put :update, id: @sms_sent, sms_sent: { text: @sms_sent.text }
    assert_redirected_to sms_sent_path(assigns(:sms_sent))
  end

  test "should destroy sms_sent" do
    assert_difference('SmsSent.count', -1) do
      delete :destroy, id: @sms_sent
    end

    assert_redirected_to sms_sents_path
  end
end
