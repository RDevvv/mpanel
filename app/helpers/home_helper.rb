module HomeHelper
    def generate_referer_link(outlet, referer_uuid, ad)
        customer_id = Customer.where(:uuid => referer_uuid).first.id

        url = "http://www.gullakmaster.com/deals/"
        url += "organic/"
        url += "facebook_share/"
        url += outlet.area.city.city_name.tr(" ","_")+"/"
        url += outlet.area.area_name.tr(" ", "_")+"/"
        url += outlet.account_brand.brand.category.category_name.tr(" ","_")+"/"
        url += customer_id.to_s+"/"
        url += ad.id.to_s+"/"

        return url
    end
end
