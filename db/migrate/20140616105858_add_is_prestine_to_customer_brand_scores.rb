class AddIsPrestineToCustomerBrandScores < ActiveRecord::Migration
  def change
      add_column :customer_brand_scores, :is_prestine, :boolean, :default => false
  end
end
