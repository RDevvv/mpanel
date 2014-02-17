ActiveAdmin.register City do
  index do
    column :id
    column :city_name
    column :time_zone
    column :country_id
    actions :defaults => false do |city|
      link_to "View", admin_city_path(city)
    end
    actions :defaults => false do |city|
      link_to "update", edit_admin_city_path(city)
    end
  end

  form do |f|
    f.inputs do
      f.input :city_name
      f.input :time_zone
      f.input :country
    end
    f.actions
  end

  show do |city|
    attributes_table do
      row :id
      row :city_name
      row :time_zone
      row :country
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end

end
