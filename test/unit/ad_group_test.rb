require 'test_helper'

class AdGroupTest < ActiveSupport::TestCase
    test "if an outlet is being deleted" do
        AdGroup.first.delete_outlet(1)
        assert_equal [], AdGroup.first.ad_promocode_outlets
    end

    test "if more outlets can be added using add_more_outlets" do
        AdGroup.first.add_more_outlets([1])
        assert_equal 4, AdPromocode.count
    end

    test "if 'all' option is selected while adding more outlets" do
        AdGroup.first.add_more_outlets(["All"])
        p AdPromocode.count
        assert_equal 4, AdPromocode.count
    end
end
