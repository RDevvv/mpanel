require 'test_helper'

class MerchantHelperTest < ActionView::TestCase

    test "should have no sidebars" do
        #assert_equal "sidebar", no_sidebar
    end

    test "should have sidebars" do
        #assert_equal "sidebar", no_sidebar
    end

    test "should display label for activate when active is true" do
        assert_equal "<span class='label label-success'>De Activate</span>", display_label_for_activate(true)
    end

    test "should display label for activate when active is false" do
        assert_equal "<span class='label label-info'>Activate</span>", display_label_for_activate
    end


    test "should display label for verify when active is true" do
        assert_equal "<span class='label label-info'>Verified</span>", display_label_for_verify(true)
    end

    test "should display label for role" do
        assert_equal "<span class='label label-success'>Admin</span>", display_label_for_role("admin")
    end

    test "should display label for exclusive when exclusive parameter is false" do
        assert_equal "<span class='label label-info'>Exclusive</span>", display_label_for_exclusive(false)
    end

    test "should display label for exclusive when exclusive parameter is true" do
        assert_equal "<span class='label label-success'>Not Exclusive?</span>", display_label_for_exclusive(true)
    end
end
