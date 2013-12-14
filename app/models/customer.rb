class Customer < ActiveRecord::Base
    attr_accessible :uuid

    def self.generate_cookie
        customer_uuid = nil
        while(customer_uuid == nil)
            customer_uuid = SecureRandom.uuid
            unless Customer.exists?(:uuid => customer_uuid)
                customer_uuid
            end
        end
        Customer.create(:uuid => customer_uuid)
        return customer_uuid
    end
end
