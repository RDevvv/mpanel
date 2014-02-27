ActiveAdmin.register Campaign do
  menu :parent => "Campaigns"

  collection_action :index, :method => :get do
    # Only get the groups owned by the current user
    scope = Campaign.where("campaign_type != 'button_click' and campaign_type != 'organic share'").scoped

    @collection = scope.page() if params[:q].blank?
    @search = scope.metasearch(clean_search_params(params[:q]))

    respond_to do |format|
      format.html {
        render "active_admin/resource/index"
      }
    end
  end

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

  form do |f|
    f.inputs do
      f.input :ad_promocode_outlet, :as => :select, :collection => AdPromocodeOutlet.all.map {|u| [u.id, u.id]}
      f.input :source
      f.input :medium
      f.input :marketer
      f.input :campaign_type
      f.input :keyword
      f.input :pre_expiry_forward_url
      f.input :post_expiry_forward_url
      f.input :short_url
      f.input :unique_key
      f.input :expires_at
      f.input :campaign_template
      f.input :purpose
      f.input :placement
      f.input :target
      f.input :campaign_name
    end
  f.actions
  end

  show do |campaign|
    attributes_table do
      row :ad_promocode_outlet do |campaign|
        if campaign.ad_promocode_outlet.present?
          campaign.ad_promocode_outlet_id
        else
          status_tag('Empty')
        end
      end
      row :source
      row :medium
      row :marketer
      row :campaign_type
      row :keyword
      row :pre_expiry_forward_url
      row :post_expiry_forward_url
      row :short_url
      row :unique_key
      row :expires_at
      row :campaign_template
      row :purpose
      row :placement
      row :target
      row :campaign_name
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
