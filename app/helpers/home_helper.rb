module HomeHelper
    def generate_title
        if controller_name == 'home'
            if action_name == 'outlet_listing'
                return "GullakMaster - Outlet View"
            elsif action_name == 'outlet_search'
                return "#{params[:search]} - Outlet Search"
            elsif action_name == 'index'
                return "GullakMaster - Home"
            else
                return "GullakMaster - Deals"
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
        if brand.attachments.blank?
            image_tag "categories/#{brand.category.category_name.gsub(" ", "_")}.png", :class => "img-responsive"
        else
            image_tag brand.attachments.first.image, :class => "img-responsive"
        end
    end

    def get_brand_title(brand_name)
        trailing_string=''
        unless brand_name.length < 17
            trailing_string='..'
        end
        brand_name[0..15]+trailing_string
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

    def get_opposite_view(current_view)
        if current_view =='outlet_listing'
            view = 'map_listing'
        elsif current_view == 'map_listing'
            view = 'outlet_listing'
        end
    end

    def get_opposite_view_class(current_view)
        if current_view =='outlet_listing'
            view = 'loc'
        elsif current_view == 'map_listing'
            view = 'outlet'
        end
    end
end
