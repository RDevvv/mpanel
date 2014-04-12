class MiscSms < ActiveRecord::Base
    belongs_to :customer
    belongs_to :button_click
    attr_accessible :is_sent, :text, :vendor_id
    validates :text, :presence => true

    after_create :send_message

    def send_message
        Resque.enqueue(ExotelMiscSms,self.id)
    end

    def get_number
        self.customer.mobile_number
    end
end
