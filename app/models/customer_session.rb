class CustomerSession < ActiveRecord::Base
    has_many :brand_sessions
    has_many :button_clicks
    belongs_to :customer
    geocoded_by :geocoding_address

    attr_accessible :browser, :browser_version, :platform, :referer_link, :customer_id, :latitude, :longitude, :campaign_url

    def geocoding_address
        "india"
    end

    def self.update_coordinates(uuid, location)
        customer = Customer.where(:uuid =>uuid)
        if customer.blank?
            customer = Customer.create(:uuid => uuid)
            customer.customer_sessions.create(:latitude => location[:latitude], :longitude => location[:longitude])
        else
            customer.first.customer_sessions.last.update_attributes(:latitude => location[:latitude], :longitude => location[:longitude])
        end
    end

end
