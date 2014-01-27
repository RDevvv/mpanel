require 'test_helper'

class AdGroupTest < ActiveSupport::TestCase
    test "if an outlet is being deleted" do
        AdGroup.first.delete_outlet(1)
        assert_equal [], AdGroup.first.ad_promocode_outlets
    end
end
