require 'test_helper'

class SmsSentsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @sms_sent = sms_sents(:one)
  end
end
