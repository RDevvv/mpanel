class CustomerSession < ActiveRecord::Base
    has_many :brand_sessions
    belongs_to :customer
    geocoded_by :geocoding_address

    attr_accessible :browser, :browser_version, :platform, :referer_link, :customer_id, :latitude, :longitude

    def geocoding_address
        "india"
    end
end
