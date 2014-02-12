ActiveAdmin.register City do
  index do
    column :id
    column :city_name
    column :time_zone
    column :created_at
    column :updated_at
    column :latitude
    column :longitude
    actions :defaults => false do |city|
      link_to "View", admin_city_path(city)
    end
    actions :defaults => false do |city|
      link_to "update", edit_admin_city_path(city)
    end
  end
end
