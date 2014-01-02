class Customer < ActiveRecord::Base
    has_many :facebook_shares
    has_many :customer_sessions
    has_many :sms_sents

    attr_accessible :uuid, :mobile_number, :browser, :platform, :browser_version, :email_id, :name, :age, :gender
    attr_accessible :date_of_birth, :incentive_count, :verification_code, :is_verified

    validates :mobile_number, :uniqueness => true, :numericality => true,:length => {:minimum => 9, :maximum => 11}, :allow_blank => true

    after_create :generate_verification_code

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

    def generate_verification_code
        self.update_attributes(:verification_code => SecureRandom.hex(4))
        text = "Your verification code is : #{self.verification_code}"
        self.sms_sents.create(:text => text)
    end
end
