namespace :data_update do
  desc "Update score for brand"
  task :brand_score => :environment do
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