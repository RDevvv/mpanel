ActiveAdmin.register Brand do

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

	form(:html => { :multipart => true }) do |f|
    	f.inputs do
        f.input :brand_name
			  f.input :website_url
			  f.input :category, :as => :select, :collection => Category.all.map {|c| [c.category_name, c.id]}
       			f.has_many :attachments do |s|
        			s.input :image, :as => :file
      			end
		    end
  		f.actions
  end

  show do
    attributes_table do
      row :id
      row :brand_name
      row :category
      row :website_url
      row :is_active
      row :is_verified
      row :created_at
      row :updated_at
      row :attachments do |brand|
        if brand.attachments.last.image.present?
          image_tag brand.attachments.last.image
        else
          status_tag('No logo uploaded')
        end
      end
    end
    active_admin_comments
  end

end
