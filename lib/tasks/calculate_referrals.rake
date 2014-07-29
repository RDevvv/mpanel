namespace :data_update do
    desc "Update referral_downloads"
    task :referral_downloads => :environment do
        customers = CustomerSession.where("customer_ip IS NOT NULL AND campaign_url ILIKE '%api%'").each do |customer_session|
            match = CustomerCampaignCopy.all.each do |ccc|
                if ccc.customer_ip == customer_session.customer_ip
                    ReferralDownload.create(:referrer_id => ccc.campaign_copy.customer.id,:referee_id => ccc.customer_id)
                end
            end
        end

        ReferralDownload.where(:is_calculated => false).each do |rd|
            user = ReferrerDownloadCount.where(:customer_id =>rd.referrer_id).first
            user = ReferrerDownloadCount.create(:customer_id => rd.referrer_id) if user.blank?
            user.update_attributes(:download_count => (user.download_count+1))
            rd.update_attributes(:is_calculated => true)
        end
    end
end
