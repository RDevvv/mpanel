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

    test "should get new" do
        get :new
        assert_response :success
    end

    test "should create call_forwarding" do
        assert_difference('CallForwarding.count') do
            post :create, call_forwarding: {  }
        end

        assert_redirected_to call_forwarding_path(assigns(:call_forwarding))
    end

    test "should show call_forwarding" do
        get :show, id: @call_forwarding
        assert_response :success
    end

    test "should get edit" do
        get :edit, id: @call_forwarding
        assert_response :success
    end

    test "should update call_forwarding" do
        put :update, id: @call_forwarding, call_forwarding: {  }
        assert_redirected_to call_forwarding_path(assigns(:call_forwarding))
    end

    test "should destroy call_forwarding" do
        assert_difference('CallForwarding.count', -1) do
            delete :destroy, id: @call_forwarding
        end

        assert_redirected_to call_forwardings_path
    end
end
