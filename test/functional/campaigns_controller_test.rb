require 'test_helper'

class CampaignsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @campaign = campaigns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:campaigns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create campaign" do
    assert_difference('Campaign.count') do
      post :create, campaign: { expires_at: @campaign.expires_at, keyword: @campaign.keyword, marketer: @campaign.marketer, medium: @campaign.medium, post_expiry_forward_url: @campaign.post_expiry_forward_url, pre_expiry_forward_url: @campaign.pre_expiry_forward_url, short_url: @campaign.short_url, source: @campaign.source, campaign_type: @campaign.campaign_type, unique_key: @campaign.unique_key }
    end

    assert_redirected_to campaign_path(assigns(:campaign))
  end

  test "should show campaign" do
    get :show, id: @campaign
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @campaign
    assert_response :success
  end

  test "should update campaign" do
    put :update, id: @campaign, campaign: { expires_at: @campaign.expires_at, keyword: @campaign.keyword, marketer: @campaign.marketer, medium: @campaign.medium, post_expiry_forward_url: @campaign.post_expiry_forward_url, pre_expiry_forward_url: @campaign.pre_expiry_forward_url, short_url: @campaign.short_url, source: @campaign.source, campaign_type: @campaign.campaign_type, unique_key: @campaign.unique_key }
    assert_redirected_to campaign_path(assigns(:campaign))
  end

  test "should destroy campaign" do
    assert_difference('Campaign.count', -1) do
      delete :destroy, id: @campaign
    end

    assert_redirected_to campaigns_path
  end
end
