require 'test_helper'

class AdTest < ActiveSupport::TestCase
    test "if individual keywords are created for an ad for it's brand" do
        Ad.first.brand_name_keyword
        assert_equal "Cafe", Ad.first.keywords.where(:keyword => "Cafe").first.keyword
        assert_equal "Coffee", Ad.first.keywords.where(:keyword => "Coffee").first.keyword
    end

    test "if entire brand name is stored as a keyword" do
        Ad.first.brand_name_keyword
        assert_equal "Cafe Coffee Day", Ad.first.keywords.where(:keyword => "Cafe Coffee Day").first.keyword
    end

    test "if individual keywords already exist in database" do
        #Ad.first.brand_name_keyword
        #assert_equal "Aura Spa", Ad.find(3).keywords.where(:keyword => "Aura Spa").first.keyword
    end

    test "if ad activity can be toggled when is_active is false" do
        Ad.first.toggle_active
        assert_equal true, Ad.first.is_active
    end

    test "if ad activity can be toggled when is_active is true" do
        Ad.last.update_attributes(:is_active => true)
        Ad.last.toggle_active
        assert_equal false, Ad.last.is_active
    end

    test "if ads are being activated" do
        Ad.first.activate
        assert_equal true, Ad.first.is_active
    end

    test "if ads are being deactivated" do
        Ad.first.deactivate
        assert_equal false, Ad.first.is_active
    end

    test "if toggle_exclusive is working when is_exclusive is false" do
        Ad.first.toggle_exclusive
        assert_equal true, Ad.first.is_exclusive
    end

    test "if toggle_exclusive is working when is_exclusive is true" do
        Ad.last.update_attributes(:is_exclusive => true)
        Ad.last.toggle_exclusive
        assert_equal false, Ad.last.is_exclusive
    end

    test "if activate_exclusive is working" do
        Ad.first.activate_exclusive
        assert_equal true, Ad.first.is_exclusive
    end

    test "if deactivate_exclusive is working" do
        Ad.first.deactivate_exclusive
        assert_equal false, Ad.first.is_exclusive
    end

    test "it ad is expired" do
        is_expired = Ad.first.expired?
        assert_equal true, is_expired
    end

    test "if category being checked when category exists" do
        category_exist = Ad.find(1).check_category?("Beverages")
        assert_equal true, category_exist
    end

    test "if category being checked when category doesn't exists" do
        category_exist = Ad.first.check_category?("Beveragess")
        assert_equal false, category_exist
    end

    test "check if check_day functioning" do
        assert_equal Ad.find(3).check_day, [0,1,2,3,4,5,6]
    end
end
