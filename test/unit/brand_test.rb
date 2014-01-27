require 'test_helper'

class BrandTest < ActiveSupport::TestCase
    test "if brand_name is being fetched" do
        brand_name = Brand.first.name
        assert_equal "CCD", brand_name
    end
end
