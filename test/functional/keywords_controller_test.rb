require 'test_helper'

class KeywordsControllerTest < ActionController::TestCase
	include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  # test "the truth" do
  #   assert true
  # end
end
