class SmsSent < ActiveRecord::Base
    belongs_to :customer
    belongs_to :ad_promocode_outlet

    attr_accessible :text, :is_sent

    validates :text, :presence => true
    validates :customer_id, :presence => true

    def message(phones, message)
        mobilenumbers = phones.join(",")
        url = URI.parse("http://www.smscountry.com/smscwebservice_bulk.aspx")
        request = Net::HTTP::Post.new(url.path)
        request.set_form_data({'user' => "gullak", 'passwd' => "babu3384ad", 'mobilenumber' => mobilenumbers, 'message' => message, 'senderid' => "Gullake", 'mtype' => "N", 'DR' => "Y"})
        response = Net::HTTP.new(url.host, url.port).start {|http| http.request(request) }
        case response
        when Net::HTTPSuccess
            puts response.body
        else
            response.body
            response.error!
        end
    end
end
