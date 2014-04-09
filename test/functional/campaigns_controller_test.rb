require 'test_helper'

class CampaignsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @campaign = campaigns(:one)
  end
end
