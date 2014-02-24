ActiveAdmin.register ErrorMessage do
    config.clear_sidebar_sections!
  index do
    column :id
    column :class_name
    column :doc_root
    column :message
    column :params
    column :target_url
    column :created_at
    actions :defaults => false do |city|
      link_to "View", admin_error_message_path(city)
    end
  end
end
