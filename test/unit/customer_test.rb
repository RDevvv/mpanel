require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
    test "check if cookies are generated" do
        uuid = Customer.generate_cookie
        assert_not_nil uuid
    end
  # test "the truth" do
  #   assert true
  # end
end
