module HomeHelper
    def generate_title
        if controller_name == 'home'
            if action_name == 'map_listing'
                return "Map View"
            elsif action_name == 'outlet_listing'
                return "Outlet View"
            elsif action_name == 'outlet_search'
                return "Outlet Search"
            elsif action_name == 'map_search'
                return "Map Search"
            elsif action_name == 'index'
                return "Home"
            else
                return "Deals"
            end
        end
    end

    def generate_referer_link(outlet, referer_uuid, ad)
        customer_id = Customer.where(:uuid => referer_uuid).first.id

        url = "http://staging.gullakmaster.com/"
        url += "deals/organic/"
        url += "facebook/"
        url += outlet.area.city.city_name.tr(" ","_")+"/"
        url += outlet.area.area_name.tr(" ", "_")+"/"
        url += outlet.account_brand.brand.category.category_name.tr(" ","_")+"/"
        url += ad.ad_promocode_outlets.where(:outlet_id => outlet.id).first.id.to_s+"/"

        return url
    end

    def get_brand_image(brand)
        if brand.attachments.empty?
            image_tag "categories/#{brand.category.category_name.gsub(" ", "_")}.png", :class => "img-responsive"
        else
            image_tag brand.attachments.first.image, :class => "img-responsive"
        end
    end

    def get_brand_title(brand)
        trailing_string=''
        unless brand.brand_name.length < 7
            trailing_string='..'
        end
        brand.brand_name[0..6]+trailing_string
    end

    def get_location_search_url
        if action_name == 'outlet_listing'
            'outlet_listing'
        else
            'map_listing'
        end
    end

    def get_keyword_search_url
        if action_name == 'outlet_listing'
            'outlet_search'
        else
            'map_search'
        end
    end

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
