require 'test_helper'

class AddressButtonSelectsControllerTest < ActionController::TestCase
  setup do
    @address_button_select = address_button_selects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:address_button_selects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create address_button_select" do
    assert_difference('AddressButtonSelect.count') do
      post :create, address_button_select: {  }
    end

    assert_redirected_to address_button_select_path(assigns(:address_button_select))
  end

  test "should show address_button_select" do
    get :show, id: @address_button_select
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @address_button_select
    assert_response :success
  end

  test "should update address_button_select" do
    put :update, id: @address_button_select, address_button_select: {  }
    assert_redirected_to address_button_select_path(assigns(:address_button_select))
  end

  test "should destroy address_button_select" do
    assert_difference('AddressButtonSelect.count', -1) do
      delete :destroy, id: @address_button_select
    end

    assert_redirected_to address_button_selects_path
  end
end
