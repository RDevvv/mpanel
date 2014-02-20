require 'test_helper'

class AccountBrandTest < ActiveSupport::TestCase
    test "if brand_name is fetched" do
        brand_name = AccountBrand.first.name
        assert_equal "Cafe Coffee Day", brand_name
    end
end
