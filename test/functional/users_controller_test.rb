require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get index" do
  end

  test "should get new" do
  end

  test "should get edit" do
  end

  test "should destroy an user" do
  end
end
