class AddKeywordIdsToAd < ActiveRecord::Migration
  def change
    add_column :ads, :keyword_ids, :integer
  end
end
