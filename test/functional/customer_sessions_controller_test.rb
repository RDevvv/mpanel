require 'test_helper'

class CustomerSessionsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
        @user = users(:one)
        sign_in @user
        @customer_session = customer_sessions(:one)
    end

    test "should get index" do
        get :index
        assert_response :success
        assert_not_nil assigns(:customer_sessions)
    end

    test "should show customer_session" do
        get :show, id: @customer_session
        assert_response :success
    end
end
