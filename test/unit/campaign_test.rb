require 'test_helper'

class CampaignTest < ActiveSupport::TestCase
    test "if campaign generates url for sharing" do
        url = Campaign.generate_url(AdPromocodeOutlet.find(1))
        assert_equal url, "http://www.gullakmaster.com/deals/organic/facebook/Mumbai/bandra/Beverages/1/"
    end
end
