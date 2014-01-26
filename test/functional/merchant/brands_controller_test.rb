require 'test_helper'

class Merchant::BrandsControllerTest < ActionController::TestCase
    include Devise::TestHelpers
    setup do
        @user = users(:one)
        @brand= brands(:one)
        sign_in @user
    end

    test "should get index" do
        get :index, account_id: 1
        assert_response :success
    end

    test "should get new" do
        get :new, account_id: 1
        assert_response :success
    end

    test "should get edit" do
        get :edit, account_id: 1, id: 1
        assert_response :success
    end

    test "should get show" do
        get :show, id: 1, account_id: 1
        assert_response :success
    end

    test "should create new brand" do
        assert_difference('Brand.count') do
            post :create, account_id: 1, brand: {brand_name: @brand.brand_name, category_id: @brand.category_id, website_url: @brand.website_url }
        end
    end

    test "should update a brand" do
        put :update, account_id: 1, id: @brand, brand: {brand_name: @brand.brand_name, category_id: @brand.category_id, website_url: @brand.website_url }

        assert_redirected_to merchant_account_brands_path
    end

    test "should destroy a brand" do
        delete :destroy, account_id: 1, id: @brand
    end

end
