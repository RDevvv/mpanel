ActiveAdmin.register Area do
  index do
    column :id
    column :area_name
    column :created_at
    column :updated_at
    column :latitude
    column :longitude
    column :pincode
    actions :defaults => false do |area|
      link_to "View", admin_area_path(area)
    end
    actions :defaults => false do |area|
      link_to "update", edit_admin_area_path(area)
    end
  end
end
