namespace :data_update do
    desc "Update brand_score"
    task :brand_score => :environment do

        ButtonClick.where(:is_score_calculated => false).each do |button_click|
            brand = button_click.outlet.account_brand.brand
            customer = button_click.customer
            brand_score = CustomerBrandScore.where(:brand_id => brand.id, :customer_id => customer.id).first
            if brand_score.nil?
                brand_score = CustomerBrandScore.create(:brand_id => brand.id,:customer_id => customer.id)
            end
            view_count,poster_share_count,unlock_count,call_count = 0,0,0,0
            if button_click.button_class =='view'
                view_count = brand_score.view+1
            elsif button_click.button_class == 'poster_share'
                poster_share_count = brand_score.poster_share+1
            elsif button_click.button_class == 'unlock'
                unlock_count = brand_score.unlock+1
            elsif button_click.button_class == 'call'
                call_count = brand_score.call+1
            end
            brand_score.update_attributes(:view => view_count, :poster_share => poster_share_count, :unlock => unlock_count,:call => call_count, :is_prestine => false)
            button_click.update_attributes(:is_score_calculated => true)
        end

        CustomerBrandScore.where(:is_prestine => false).each do |score|
            brand_score = (score.view * 2) + (score.call) + (score.unlock * 4) + (score.poster_share * 3)
            score.update_attributes(:score => brand_score, :is_prestine => true)
        end
    end
end
