require 'test_helper'

class AccountBrandTest < ActiveSupport::TestCase
    test "if brand_name is fetched" do
        brand_name = AccountBrand.first.name
        assert_equal "CCD", brand_name
    end
end
