class CustomerLocation < ActiveRecord::Base
    belongs_to :native_notification
    belongs_to :customer

    attr_accessible :latitude, :longitude, :customer_id, :native_notification_id

    geocoded_by :geocoding_method

    def geocoding_method
        ''
    end

end
