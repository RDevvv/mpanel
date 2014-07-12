require 'test_helper'

class CustomerCampaignCopiesControllerTest < ActionController::TestCase
  setup do
    @customer_campaign_copy = customer_campaign_copies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customer_campaign_copies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer_campaign_copy" do
    assert_difference('CustomerCampaignCopy.count') do
      post :create, customer_campaign_copy: { customer_ip: @customer_campaign_copy.customer_ip }
    end

    assert_redirected_to customer_campaign_copy_path(assigns(:customer_campaign_copy))
  end

  test "should show customer_campaign_copy" do
    get :show, id: @customer_campaign_copy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @customer_campaign_copy
    assert_response :success
  end

  test "should update customer_campaign_copy" do
    put :update, id: @customer_campaign_copy, customer_campaign_copy: { customer_ip: @customer_campaign_copy.customer_ip }
    assert_redirected_to customer_campaign_copy_path(assigns(:customer_campaign_copy))
  end

  test "should destroy customer_campaign_copy" do
    assert_difference('CustomerCampaignCopy.count', -1) do
      delete :destroy, id: @customer_campaign_copy
    end

    assert_redirected_to customer_campaign_copies_path
  end
end
