require 'test_helper'

class LeadsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @lead = leads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:leads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lead" do
    assert_difference('Lead.count') do
      post :create, lead: { company_name: @lead.company_name, designation: @lead.designation, email: 'asdf@gmaill.com', first_name: @lead.first_name, last_name: @lead.last_name, mobile_number: @lead.mobile_number, source: @lead.source, subscribe_email_updates: @lead.subscribe_email_updates, target: @lead.target }
    end

    assert_redirected_to leads_path
  end

  test "should show lead" do
    get :show, id: @lead
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lead
    assert_response :success
  end

  test "should update lead" do
    put :update, id: @lead, lead: { company_name: @lead.company_name, designation: @lead.designation, email: @lead.email, first_name: @lead.first_name, last_name: @lead.last_name, mobile_number: @lead.mobile_number, source: @lead.source, subscribe_email_updates: @lead.subscribe_email_updates, target: @lead.target }
    assert_redirected_to leads_path
  end

  test "should destroy lead" do
    assert_difference('Lead.count', -1) do
      delete :destroy, id: @lead
    end

    assert_redirected_to leads_path
  end
end
