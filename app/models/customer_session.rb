class CustomerSession < ActiveRecord::Base
    has_many :brand_sessions
    belongs_to :customer

    attr_accessible :browser, :browser_version, :platform, :referer_link, :customer_id
end
