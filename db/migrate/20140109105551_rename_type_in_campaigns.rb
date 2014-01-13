class RenameTypeInCampaigns < ActiveRecord::Migration
    rename_column :campaigns, :type, :campaign_type
end
