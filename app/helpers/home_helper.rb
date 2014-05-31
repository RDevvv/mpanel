module HomeHelper
    def check_if_verified(uuid)
        customer =Customer.where(:uuid => uuid)
        if customer.blank?
            return 0
        elsif customer.first.is_verified.blank?
            return 0
        else 
            1
        end
    end
end
