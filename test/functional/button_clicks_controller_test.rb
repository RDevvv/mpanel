require 'test_helper'

class ButtonClicksControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
        @user = users(:one)
        sign_in @user
        @button_click = button_clicks(:one)
    end

    test "should create button_click" do
        assert_difference('ButtonClick.count') do
            get :get_click, customer_uuid: 'a1825be5-36b7-40dd-9e06-0bf58920235d' , button_click: { ad_id: @button_click.ad_id, button_class: @button_click.button_class}
        end

        assert_redirected_to button_click_path(assigns(:button_click))
    end
end
