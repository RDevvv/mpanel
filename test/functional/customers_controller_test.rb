require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
        @user = users(:one)
        sign_in @user
        @customer = customers(:one)
    end

    test "should get index" do
        get :index
        assert_response :success
        assert_not_nil assigns(:customers)
    end

    test "should get new" do
        get :new
        assert_response :success
    end

    test "should create customer" do
        assert_difference('Customer.count') do
            post :create, customer: { uuid: @customer.uuid }
        end

        assert_redirected_to customer_path(assigns(:customer))
    end

    test "should show customer" do
        get :show, id: @customer
        assert_response :success
    end

    test "should get edit" do
        get :edit, id: @customer
        assert_response :success
    end

    test "should update customer" do
        put :update, id: @customer, customer: { uuid: @customer.uuid }
        assert_redirected_to customer_path(assigns(:customer))
    end

    test "should destroy customer" do
        assert_difference('Customer.count', -1) do
            delete :destroy, id: @customer
        end

        assert_redirected_to customers_path
    end

    test "should verify mobile number when verification code is correct" do
        @request.cookies['uuid'] = 'a1825be5-36b7-40dd-9e06-0bf58920235d'
        post :verify_mobile_number, verification_code: 'c15d484e'
        assert_response :success
    end

    test "should verify mobile number when verification code is incorrect" do
        @request.cookies['uuid'] = 'a1825be5-36b7-40dd-9e06-0bf58920235d'
        post :verify_mobile_number, verification_code: '24123'
        assert_response :success
    end

    test "should get mobile number" do
    end
end
