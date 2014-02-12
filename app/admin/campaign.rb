ActiveAdmin.register Campaign.where("campaign_type != 'button_click' and campaign_type != 'organic share'") do
  index do
    column :id
    column :source
    column :medium
    column :marketer
    column :campaign_type
    column :keyword
    column :pre_expiry_forward_url
    column :post_expiry_forward_url
    column :short_url
    column :expires_at
    actions :defaults => false do |campaign|
      link_to "View", admin_campaign_path(campaign)
    end
    actions :defaults => false do |campaign|
      link_to "update", edit_admin_campaign_path(campaign)
    end
  end
end
