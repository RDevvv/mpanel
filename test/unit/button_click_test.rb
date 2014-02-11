require 'test_helper'

class ButtonClickTest < ActiveSupport::TestCase
    test "if version details being added to a button_click" do
        is_details_added = ButtonClick.first.add_version_details
        assert_equal true, is_details_added
    end
end
