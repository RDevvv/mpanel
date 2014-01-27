require 'test_helper'

class CountryTest < ActiveSupport::TestCase
    test "if country name is being fetched" do
        name = Country.first.name
        assert_equal "Australia", name

    end
end
