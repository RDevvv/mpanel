class AddTemplateToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :campaign_template, :string
  end
end
