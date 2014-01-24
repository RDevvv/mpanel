require 'test_helper'

class HomeControllerTest < ActionController::TestCase
    include Devise::TestHelpers

    setup do
        @user = users(:one)
        sign_in @user
        @request.env['HTTP_HOST'] = 'localhost:3000'
        @request.env['ORIGINAL_FULLPATH'] = '/map_listing'
    end

    test "should get map_listing" do
        get :map_listing, :location => "bandra"
        assert_response :success
    end

    test "should get outlet_listing" do
        get :outlet_listing, :location => "bandra"
        assert_response :success
    end
end
