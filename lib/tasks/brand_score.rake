namespace :data_update do
  desc "Update score for brand"
  task :brand_score => :environment do

    #ButtonClick.where(" button_class = 'like' or button_class = 'call' or button_class = 'poster share' or button_class = 'description' ").all.each do |button|
    #  if button.outlet_id.present?
    #    @outlet = Outlet.where(:id => button.outlet_id).first
    #    @account_brand = @outlet.account_brand
    #    brand = @account_brand.brand.id



    #      if CustomerBrandScore.where("customer_id = '#{button.customer_id}' and brand_id = '#{brand}'").present?
    #        CustomerBrandScore.where("customer_id = '#{button.customer_id}' and brand_id = '#{brand}'").all.each do |a|
    #          if button.button_class == "like"
    #            a.update_attributes(:unlock_count => a.unlock_count+1)
    #          end
    #          if button.button_class == "poster share"
    #            a.update_attributes(:share_count => a.share_count+1)
    #          end
    #          if button.button_class == "call"
    #            a.update_attributes(:call_count => a.call_count+1)
    #          end
    #          if button.button_class == "description"
    #            a.update_attributes(:view_count => a.view_count+1)
    #          end
    #        end
    #      else
    #        if button.button_class == "like"
    #          CustomerBrandScore.create(:customer_id => button.customer_id, :brand_id => brand, :view_count => 0, :call_count => 0, :share_count => 0, :unlock_count => 1)
    #        end
    #        if button.button_class == "call"
    #          CustomerBrandScore.create(:customer_id => button.customer_id, :brand_id => brand, :view_count => 0, :call_count => 1, :share_count => 0, :unlock_count => 0)
    #        end
    #        if button.button_class == "share"
    #          CustomerBrandScore.create(:customer_id => button.customer_id, :brand_id => brand, :view_count => 0, :call_count => 0, :share_count => 1, :unlock_count => 0)
    #        end
    #        if button.button_class == "description"
    #          CustomerBrandScore.create(:customer_id => button.customer_id, :brand_id => brand, :view_count => 1, :call_count => 0, :share_count => 0, :unlock_count => 0)
    #        end
    #      end
    #  end
    #end

    CustomerBrandScore.all.each do |score|
      view_count = score.view_count
      call_count = score.call_count
      unlock_count = score.unlock_count
      share_count = score.share_count
      brand_score = (view_count * 2) + (call_count) + (unlock_count * 4) + (share_count * 3)
      score.update_attributes(:score => brand_score)
    end
  end
end