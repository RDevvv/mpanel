class ChangeNamesInCustomerBrandScore < ActiveRecord::Migration
  def change
      remove_column :customer_brand_scores, :call_count
      remove_column :customer_brand_scores, :share_count
      remove_column :customer_brand_scores, :unlock_count
      remove_column :customer_brand_scores, :view_count

      add_column :customer_brand_scores, :call, :integer, :default => 0
      add_column :customer_brand_scores, :share, :integer, :default => 0
      add_column :customer_brand_scores, :poster_share, :integer, :default => 0
      add_column :customer_brand_scores, :unlock, :integer, :default => 0
      add_column :customer_brand_scores, :view, :integer, :default => 0
  end
end
