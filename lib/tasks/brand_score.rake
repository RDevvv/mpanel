namespace :data_update do
  desc "Update score for brand"
  task :brand_score => :environment do

    ButtonClick.where("button_class == 'like' or button_class == 'call' or button_class == 'share' or button_class == 'description'").all.each do |button|
      if button.outlet_id.present?
        @outlet = Outlet.where(:id => button.outlet_id).first
        @account_brand = @outlet.account_brand
        brand = @account_brand.brand.id
      end

      if button.button_class == "like"
        unlock_count = 1
        call_count = 0
        share_count = 0
        view_count = 0
      elsif button.button_class == "call"
        call_count = 1
        unlock_count = 0
        share_count = 0
        view_count = 0
      elsif button.button_class == "poster share"
        share_count = 1
        unlock_count = 0
        call_count = 0
        view_count = 0
      elsif button.button_class == "description"
        share_count = 0
        unlock_count = 0
        call_count = 0
        view_count = 1
      end
      CustomerBrandScore.create(:customer_id => button.customer_id, :brand_id => brand, :call_count => call_count, :share_count => share_count, :unlock_count => unlock_count, :view_count => view_count)
    end

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