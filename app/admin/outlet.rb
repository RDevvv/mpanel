ActiveAdmin.register Outlet do
  menu :label => "Nongeocoded Outlets"

  collection_action :index, :method => :get do
    # Only get the groups owned by the current user
    scope = Outlet.where(:latitude => nil).scoped

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
    column :shop_no
    column :address
    column :phone_number
    column :mobile_number
    column :is_active
    column :is_verified
    column :latitude
    column :longitude
    column :outlet_key
    actions :defaults => false do |outlet|
      link_to "View", admin_outlet_path(outlet)
    end
    actions :defaults => false do |outlet|
      link_to "update", edit_admin_outlet_path(outlet)
    end
  end
end

