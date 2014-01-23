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

  test "should show sms_sent" do
    get :show, id: @sms_sent
    assert_response :success
  end
end
