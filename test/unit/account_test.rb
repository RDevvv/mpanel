require 'test_helper'

class AccountTest < ActiveSupport::TestCase
    test "should add owner to account" do
        Account.first.add_owner
        assert_equal Role.last.name, "owner"
        assert_equal Role.last.resource_type, "Account"
    end

    test "should get account name" do
        company_name = Account.first.name
        assert_equal "Gullak", company_name
    end

    test "if default admin user is added when account with email id merchant@gullakmaster.com is present" do
        User.create(:email => "merchant@gullakmaster.com", :password => "gmkg2013", :password_confirmation => "gmkg2013", :first_name => "Abhishek", :last_name => "Dadoo", :mobile_number => "983000000000", :user_key => "abcdef", :is_active => true, :email_verified => true, :mobile_verified => false)
        Account.first.add_default_admin_user
        assert_equal User.where(:email => "merchant@gullakmaster.com").first.id,UserAccount.last.user_id
    end

    test "if default admin user is added when account with email id merchant@gullakmaster.com is not present" do
        Account.first.add_default_admin_user
        assert_equal User.where(:email => "merchant@gullakmaster.com").first.id,UserAccount.last.user_id
    end
end
