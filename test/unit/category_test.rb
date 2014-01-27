require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
    test "should get category name" do
        name = Category.first.name
        assert_equal "Spa", name
    end
end
