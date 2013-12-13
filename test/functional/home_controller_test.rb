require 'test_helper'

class HomeControllerTest < ActionController::TestCase
    test "should get map_listing" do
        get :map_listing
        assert_response :success
    end

    test "should get outlet_listing" do
        get :outlet_listing, :location => "bandra"
        assert_response :success
    end

    test "should get individual_outlet" do
        get :individual_outlet, :id => 1
        assert_response :success
    end
end
