class Campaign < ActiveRecord::Base
    belongs_to :ad_promocode_outlet
    attr_accessible :expires_at, :keyword, :marketer, :medium, :post_expiry_forward_url, :pre_expiry_forward_url, :short_url, :source, :type, :unique_key

    def self.generate_url(ad_promocode_outlets)
        outlet = ad_promocode_outlets.outlet
        ad = ad_promocode_outlets.ad

        pre_expiry_forward_url = "http://www.gullakmaster.com/deals/"
        pre_expiry_forward_url += "organic/"
        pre_expiry_forward_url += "facebook_share/"
        pre_expiry_forward_url += outlet.area.city.city_name.tr(" ","_")+"/"
        pre_expiry_forward_url += outlet.area.area_name.tr(" ", "_")+"/"
        pre_expiry_forward_url += outlet.account_brand.brand.category.category_name.tr(" ","_")+"/"
        pre_expiry_forward_url += ad.id.to_s+"/"

        expires_at = Time.now+100.years
        short_url = SecureRandom.urlsafe_base64(3)
        Campaign.create(:short_url => short_url, :ad_promocode_outlets_id => ad_promocode_outlets.id, :expires_at => expires_at, :pre_expiry_forward_url => pre_expiry_forward_url, :campaign_type => 'organic share', :medium => "wall post", :source => "facebook")

        return pre_expiry_forward_url
    end
end
