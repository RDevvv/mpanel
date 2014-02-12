ActiveAdmin.register Campaign do
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
    column :unique_key
    column :expires_at
    column :created_at
    column :updated_at
    column :campaign_template
    column :purpose
    column :placement
    column :target
    column :campaign_name
    actions :defaults => false do |campaign|
      link_to "View", admin_campaign_path(campaign)
    end
    actions :defaults => false do |campaign|
      link_to "update", edit_admin_campaign_path(campaign)
    end
  end
end
