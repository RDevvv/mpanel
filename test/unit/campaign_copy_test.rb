require 'test_helper'

class CampaignCopyTest < ActiveSupport::TestCase
    test "if short_url is being generated for campaign_copies" do
        CampaignCopy.find(1).create_short_url
        assert_not_nil CampaignCopy.find(1).short_url
    end
end
