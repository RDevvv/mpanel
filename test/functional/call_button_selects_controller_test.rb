require 'test_helper'

class CallButtonSelectsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
        @user = users(:one)
        sign_in @user
        @call_button_select = call_button_selects(:one)
    end

    test "should get index" do
        get :index
        assert_response :success
        assert_not_nil assigns(:call_button_selects)
    end

    test "should get new" do
        get :new
        assert_response :success
    end

    test "should create call_button_select" do
        assert_difference('CallButtonSelect.count') do
            post :create, call_button_select: {  }
        end

        assert_redirected_to call_button_select_path(assigns(:call_button_select))
    end

    test "should show call_button_select" do
        get :show, id: @call_button_select
        assert_response :success
    end

    test "should get edit" do
        get :edit, id: @call_button_select
        assert_response :success
    end

    test "should update call_button_select" do
        put :update, id: @call_button_select, call_button_select: {  }
        assert_redirected_to call_button_select_path(assigns(:call_button_select))
    end

    test "should destroy call_button_select" do
        assert_difference('CallButtonSelect.count', -1) do
            delete :destroy, id: @call_button_select
        end

        assert_redirected_to call_button_selects_path
    end
end
