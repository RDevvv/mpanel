ActiveAdmin.register Category do
  menu :parent => "Master Tables"
  index do
    column :id
    column :category_name
    column :industry do |category|
      if category.industry.present?
        category.industry.industry_name
      else
        status_tag('Empty')
      end
    end
    actions :defaults => false do |category|
      link_to "View", admin_category_path(category)
    end
    actions :defaults => false do |category|
      link_to "update", edit_admin_category_path(category)
    end
  end

  form(:html => { :multipart => true }) do |f|
    f.inputs  do
      f.input :category_name, :as => :string
      f.input :industry, :as => :select, :collection => Industry.all.map {|u| [u.industry_name, u.id]}
      f.has_many :attachments do |s|
        s.input :image, :as => :file
      end
    end
    f.actions
  end

  show do |category|
    attributes_table do
      row :id
      row :category_name
      row :industry do |category|
        if category.industry.present?
          category.industry.industry_name
        else
          status_tag('Empty')
        end
      end
      row :created_at
      row :updated_at
      row :attachments do |category|
        if category.attachments.present?
          image_tag category.attachments.last.image
        else
          status_tag('No logo uploaded')
        end
      end
    end
    active_admin_comments
  end

end
