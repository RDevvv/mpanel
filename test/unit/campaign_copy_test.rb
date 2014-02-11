require 'test_helper'

class CampaignCopyTest < ActiveSupport::TestCase
    test "if short_url is being generated for campaign_copies" do
        CampaignCopy.first.create_short_url
        assert_not_nil CampaignCopy.first.short_url
    end
end
