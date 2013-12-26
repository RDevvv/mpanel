class Customer < ActiveRecord::Base
    has_many :facebook_shares

    attr_accessible :uuid, :browser, :platform, :browser_version, :email_id, :name, :age, :gender, :date_of_birth, :incentive_count

    def self.generate_cookie
        customer_uuid = nil
        while(customer_uuid == nil)
            customer_uuid = SecureRandom.uuid
            unless Customer.exists?(:uuid => customer_uuid)
                customer_uuid
            end
        end
        return customer_uuid
    end
end
