ActiveAdmin.register Outlet do
  menu :label => "Nongeocoded Outlets", :parent => "Geocoding"

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

  action_item only:[:index] do
    button_to "Geocode new outlets", "/admin/outlets/geocodes", :method => :post, :confirm => "Want to geocode outlets?"
  end

  collection_action :geocodes, :method => :post do
    system "rake geocode:all RAILS_ENV=production CLASS=Outlet"
    redirect_to admin_outlets_path
  end

  action_item only:[:index] do
    link_to "Remove irregular geocoding", "/admin/outlets/remove_geocoding", :method => :post, :confirm => "Want to remove irregular geocoding?"
  end

  collection_action :remove_geocoding, :method => :post do
      Outlet.where('latitude IS NOT NULL AND longitude IS NOT NULL').includes(:area => :city).each do |outlet|
          if outlet.latitude==outlet.area.city.latitude&&outlet.longitude==outlet.area.city.longitude
              outlet.update_attributes(:latitude => nil, :longitude => nil)
          end
      end
    redirect_to admin_outlets_path
  end

  action_item only:[:index] do
    link_to "Update unlock count", "/admin/outlets/unlock_count", :method => :post, :confirm => "Want to remove irregular geocoding?"
  end

  collection_action :unlock_count, :method => :post do
    system "rake data_update:ad_usage RAILS_ENV=production CLASS=Outlet"
    redirect_to admin_outlets_path
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

  collection_action :download_report, :method => :get do
      outlets = Outlet.where(:latitude => nil)
      csv = CSV.generate( encoding: 'Windows-1251' ) do |csv|
          # add header
          # add data
          outlets.each do |outlet|
              csv << [ outlet.id, outlet.shop_no, outlet.address, outlet.area.area_name, outlet.area.city.city_name, outlet.latitude, outlet.longitude, outlet.area.pincode, outlet.account_brand.brand.brand_name ]
          end
      end
      # send file to user
      send_data csv.encode('utf-8'), type: 'text/csv; charset=utf-8; header=present', disposition: "attachment; filename=report.csv"
  end

  action_item only: :index do
      link_to('csv report', params.merge(:action => :download_report))
  end

end

