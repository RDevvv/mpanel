namespace :data_update do
    desc "Update indices for category keywords"
    task :category_keywords => :environment do
        Ad.all.each do |ad|
            category_name = ad.account_brand.brand.category.category_name
            keywords = Keyword.where(:keyword => category_name)
            if keywords.empty?
                keyword = Keyword.create(:keyword => category_name)
                keyword.ad_keywords.create(:ad_id => ad.id)
                category_name.split(" ").each do |word|
                    unless Keyword.exists?(:keyword => word)
                        new_keyword = Keyword.create(:keyword => word)
                        new_keyword.ad_keywords.create(:ad_id => ad.id)
                    else
                        Keyword.where(:keyword => word).first.ad_keywords.create(:ad_id => ad.id)
                    end
                end
            else
                keywords.first.ad_keywords.create(:ad_id => ad.id)
                category_name.split(" ").each do |word|
                    Keyword.where(:keyword => word).first.ad_keywords.create(:ad_id => ad.id)
                end
            end
        end
    end
end
