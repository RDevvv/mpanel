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

    test "should get new" do
        get :new
        assert_response :success
    end

    test "should create customer_session" do
        assert_difference('CustomerSession.count') do
            post :create, customer_session: { browser: @customer_session.browser, browser_version: @customer_session.browser_version, platform: @customer_session.platform, referer_link: @customer_session.referer_link }
        end

        assert_redirected_to customer_session_path(assigns(:customer_session))
    end

    test "should show customer_session" do
        get :show, id: @customer_session
        assert_response :success
    end

    test "should get edit" do
        get :edit, id: @customer_session
        assert_response :success
    end

    test "should update customer_session" do
        put :update, id: @customer_session, customer_session: { browser: @customer_session.browser, browser_version: @customer_session.browser_version, platform: @customer_session.platform, referer_link: @customer_session.referer_link }
        assert_redirected_to customer_session_path(assigns(:customer_session))
    end

    test "should destroy customer_session" do
        assert_difference('CustomerSession.count', -1) do
            delete :destroy, id: @customer_session
        end

        assert_redirected_to customer_sessions_path
    end
end
