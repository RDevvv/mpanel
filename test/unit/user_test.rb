require 'test_helper'

class UserTest < ActiveSupport::TestCase
    test "if admin role being added" do
        User.first.add_admin
        assert_equal "admin", User.first.roles.first.name
    end

    test "if returns user_name" do
        user_name = User.first.user_name
        assert_equal "vivek varade", user_name
    end

    test "if returns name" do
        name = User.first.name
        assert_equal "vivek varade", name
    end

    test "if adds an account" do
        User.first.add_account(Account.first)
        assert_equal UserAccount.last.account_id, Account.first.id
        assert_equal UserAccount.last.user_id, User.first.id
    end
end
