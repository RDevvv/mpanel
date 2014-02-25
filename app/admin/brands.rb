ActiveAdmin.register Brand do
  menu :label => "Redundant Geocoding"

  index do
    column :id do |brand|
      link_to "#{brand.id}"
    end
    column :brand_name
    column :website_url
    column :is_active
    column :is_verified
    actions :defaults => false do |brand|
      link_to "View", admin_brand_path(brand)
    end
    actions :defaults => false do |brand|
      link_to "update", edit_admin_brand_path(brand)
    end
  end

end
