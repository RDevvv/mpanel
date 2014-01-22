require 'test_helper'

class EmailerTest < ActionMailer::TestCase
	include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  # test "the truth" do
  #   assert true
  # end
end
