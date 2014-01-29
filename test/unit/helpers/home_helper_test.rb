require 'test_helper'

class HomeHelperTest < ActionView::TestCase
    test "should get default category image" do
        assert_equal "<img alt=\"Spa\" class=\"img-responsive\" src=\"/images/categories/Spa.png\" />", get_brand_image(Brand.last)
    end

    test "should get brand image" do
        #puts Brand.first.attachments.first.image
        #assert_equal "<img alt=\"Cafe Coffee Day\" class=\"img-responsive\" src=\"/images/categories/CCD.png\" />", get_brand_image(Brand.first)
    end

    test "should get brand title which is smaller than 7 characters" do
        assert_equal "Cafe Co..", get_brand_title(Brand.first)
    end

    test "should get brand title which is bigger than 7 characters" do
        assert_equal "Aura Sp..", get_brand_title(Brand.last)
    end

    test "should generate referer link" do
        assert_equal "http://staging.gullakmaster.com/deals/organic/facebook/Mumbai/nerul/Spa/1/", generate_referer_link(Outlet.first, "a1825be5-36b7-40dd-9e06-0bf58920235d", Ad.first)
    end
end
