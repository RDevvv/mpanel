require 'test_helper'

class CampaignTest < ActiveSupport::TestCase
    test "if campaign generates url for sharing" do
        url = Campaign.generate_url(AdPromocodeOutlet.first)
        assert_equal url, "http://www.gullakmaster.com//deals/organic/facebook/Mumbai/nerul/Spa/1/"
    end
end
