module ApplicationHelper
    def get_og_tags
        uri = request.env["REQUEST_URI"]
        short_url = request.env["action_dispatch.request.unsigned_session_cookie"]["referer"][1][:path].gsub("/","")
        campaign_copy = CampaignCopy.where(:short_url => short_url)
        if campaign_copy.blank?
            og_title = "GullakMaster | Deals at your Fingertips"
            og_image = "http://www.gullakmaster.com/assets/gullak-logo-mcc.png"
        else
            ad = campaign_copy.first.campaign.ad_promocode_outlet.ad
            og_title = ad.ad_title+" "+ad.account_brand.brand.brand_name

            if ad.attachments.blank?
                og_image = "http://www.gullakmaster.com/assets/gullak-logo-mcc.png"
            else
                og_image = ad.attachments.first.image
            end
        end
        @tags = [og_title, og_image]
    end
end
