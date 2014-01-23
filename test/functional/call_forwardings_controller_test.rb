require 'test_helper'

class CallForwardingsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
        @user = users(:one)
        sign_in @user
        @call_forwarding = call_forwardings(:one)
    end

    test "should get index" do
        get :index
        assert_response :success
        assert_not_nil assigns(:call_forwardings)
    end

    test "should show call_forwarding" do
        get :show, id: @call_forwarding
        assert_response :success
    end
end
