require 'test_helper'

class AdPromocodeTest < ActiveSupport::TestCase
    test "if ad group is added" do
        AdPromocode.find(1).add_ad_group(Ad.find(1), "new group")
        assert_equal Ad.find(1).ad_groups.last.name, "new group"
    end

    test "if ad_id is added to ad_promocode from ad_group" do
        AdPromocode.find(1).add_ad
        assert_equal AdPromocode.find(1).ad_id, AdPromocode.find(1).ad_group.ad.id
    end
end
