class Customer < ActiveRecord::Base
    attr_accessible :uuid, :browser, :platform, :browser_version

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