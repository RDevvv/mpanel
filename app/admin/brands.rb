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

end
