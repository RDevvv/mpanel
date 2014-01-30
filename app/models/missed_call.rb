class MissedCall < ActiveRecord::Base
    belongs_to :campaign
    attr_accessible :call_sid, :from, :is_valid, :to, :campaign_id

    def self.add_exotel_campaign()
        Campaign.create(:marketer => "GM Marketer", :target => "customer", :source => "exotel", :medium => "SMS", :type => "auto trigger", :purpose => "acquisition", :campaign_template => "Your contest entry is confirmed. We will call the lucky winner of Samsung Grand 2 on 14/02/14. Try gullak.co/xxxx for more Deals At Your Fingertips")
    end
end
