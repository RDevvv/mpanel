class Campaign < ActiveRecord::Base
    belongs_to :ad_promocode_outlet

    validates :short_url, :uniqueness => true

    attr_accessible :target, :placement, :purpose, :campaign_url, :campaign_template, :campaign_type, :ad_promocode_outlet_id, :expires_at, :keyword, :marketer, :medium, :post_expiry_forward_url, :pre_expiry_forward_url, :short_url, :source, :unique_key

    def self.generate_url(ad_promocode_outlet)
        outlet = ad_promocode_outlet.outlet
        ad = ad_promocode_outlet.ad

        pre_expiry_forward_url = "http://www.gullakmaster.com/"
        pre_expiry_forward_url += "/deals/organic/"
        pre_expiry_forward_url += "facebook/"
        pre_expiry_forward_url += outlet.area.city.city_name.tr(" ","_")+"/"
        pre_expiry_forward_url += outlet.area.area_name.tr(" ", "_")+"/"
        pre_expiry_forward_url += outlet.account_brand.brand.category.category_name.tr(" ","_")+"/"
        pre_expiry_forward_url += ad_promocode_outlet.id.to_s+"/"

        campaign_template= "this is a template"
        expires_at = Time.now+100.years
        short_url = SecureRandom.urlsafe_base64(3)
        Campaign.create(:marketer => "customer", :target => "customer", :placement => "user_feed", :purpose => "acquisition", :campaign_template => campaign_template, :short_url => short_url, :ad_promocode_outlet_id => ad_promocode_outlet.id, :expires_at => expires_at, :pre_expiry_forward_url => pre_expiry_forward_url, :campaign_type => 'button_click', :medium => "organic", :source => "facebook")

        return pre_expiry_forward_url
    end
end
