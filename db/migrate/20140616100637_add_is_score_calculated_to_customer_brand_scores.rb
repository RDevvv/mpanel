class AddIsScoreCalculatedToCustomerBrandScores < ActiveRecord::Migration
  def change
      add_column :button_clicks, :is_score_calculated, :boolean, :default => false
  end
end
