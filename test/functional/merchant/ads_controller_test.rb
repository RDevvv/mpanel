require 'test_helper'

class Merchant::AdsControllerTest < ActionController::TestCase
	include Devise::TestHelpers

 # setup do
 #   @user = users(:one)
 #   sign_in @user
 #   @ad = ads(:one)
 #   @controller = Merchant::AdsController.new
 # end

 # test "should get index" do
 #   get :index
 #   assert_response :success
 # end

 # test "should get new" do
 #   get :new
 #   assert_response :success
 # end

 # test "should create ad" do
 #   assert_difference('Ad.count') do
 #       post :create, ad: { ad_title: @ad.ad_title, start_date: @ad.start_date, expiry_date: @ad.expiry_date, sms_text: @ad.sms_text}
 #   end

 #   assert_redirected_to new_ad_promocode_path
 # end

 # test "should show ad" do
 #   get :show, id: @ad
 #   assert_response :success
 # end

 # test "should get edit" do
 #   get :edit, id: @ad
 #   assert_response :success
 # end

 # test "should update ad" do
 #     post :update, id: @ad, ad: { ad_title: @ad.ad_title, start_date: @ad.start_date, expiry_date: @ad.expiry_date, sms_text: @ad.sms_text}
 #     assert_response :success
 # end

 # test "should destroy ad" do
 #     assert_difference('Ad.count', -1) do
 #         delete :destroy, id: @ad
 #     end

 #     assert_redirected_to ads_path
 # end
end