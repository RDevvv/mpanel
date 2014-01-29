require 'test_helper'

class BrandTest < ActiveSupport::TestCase
    test "if brand_name is being fetched" do
        brand_name = Brand.first.name
        assert_equal "Cafe Coffee Day", brand_name
    end
end
