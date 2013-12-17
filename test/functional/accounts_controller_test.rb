require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
        @user = users(:one)
        sign_in @user
    end

    test "should get index" do
        #get :merchant_accounts
    end

    test "should get new" do
    end

    test "should get edit" do
    end

    test "should destroy an account" do
    end
end
