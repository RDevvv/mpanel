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

   # test "should get_customer_number" do
   #     get :get_customer_number, From: [989898989898]
   #     assert_response :success
   # end

   # test "should return_outlet_number" do
   #     get :return_outlet_number, CallSid: "dummy_sid"
   #     assert_response :success
   # end

   # test "should store_call_details" do
   #     get :store_call_details, customer_uuid: "a1825be5-36b7-40dd-9e06-0bf58920235d"
   #     assert_response :success
   # end
end
