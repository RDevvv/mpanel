class Customer < ActiveRecord::Base
    has_many :facebook_shares
    has_many :customer_sessions

    attr_accessible :uuid, :mobile_number, :browser, :platform, :browser_version, :email_id, :name, :age, :gender, :date_of_birth, :incentive_count

    validates :mobile_number, :uniqueness => true, :numericality => true,:length => {:minimum => 9, :maximum => 11}, :allow_blank => true

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
