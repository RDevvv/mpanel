namespace :data_update do
    desc "Update indices for category keywords"
    task :ad_usage => :environment do
        Ad.where('usage < 10').each do |ad|
            usage = ad.account_brand.outlets.count
            ad.update_attributes(:usage => usage)
        end
    end
end
