require 'test_helper'

class AdPromocodeOutletTest < ActiveSupport::TestCase
    test "if ad being added to ad_promocode_outlet" do
        AdPromocodeOutlet.first.add_ad
        assert_equal AdPromocodeOutlet.first.ad_id, AdPromocodeOutlet.first.ad_promocode.ad.id
    end
end
