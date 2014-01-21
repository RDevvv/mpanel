module HomeHelper
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
end
