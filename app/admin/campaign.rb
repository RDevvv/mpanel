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

  form(:html => { :multipart => true }) do |f|
    f.inputs do
      f.input :ad_promocode_outlet, :as => :select, :collection => AdPromocodeOutlet.all.map {|ad| [ad.id, ad.id]}
      f.input :source, :as => :select, :collection => [["Social Media","Social Media"],["Google","Google"], ["Mobile Web","Mobile Web"],["Blog","Blog"],["Mobile App","Mobile App"]]
      f.input :medium, :as => :select, :collection => [["CPC","CPC"],["CPM","CPM"],["SMS","SMS"],["Email","Email"],["Wall","Wall"],["In App","In App"],["Native Client",["Native Client"]]]
      f.input :marketer, :as => :select, :collection => [["Customer","Customer"],["Business","Business"],["Shoffr","Shoffr"]]
      f.input :campaign_type, :as => :select, :collection => [["1T1 Button Click","1T1 Button Click"],["1T1 Auto Trigger","1T1 Auto Trigger"],["1TM Manual","1TM Manual"],["1TM Direct Share","1TM Direct Share"]]
      f.input :keyword
      f.input :expires_at
      f.input :campaign_template
      f.input :purpose, :as => :select, :collection => [["Retention","Retention"],["Acquisition","Acquisition"],["Lead Generation","Lead Generation"]]
      f.input :placement, :as => :select, :collection => [["Right Hand Side","Right Hand Side"],["User Feed","User Feed"]]
      f.input :target, :as => :select, :collection => [["Customer","Customer"],["Business","Business"]]
      f.input :campaign_name
    end
  end

end
