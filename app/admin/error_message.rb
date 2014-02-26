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
    actions :defaults => false do |error_message|
      link_to "View", admin_error_message_path(error_message)
    end
    actions :defaults => false do |error_message|
      link_to "Delete", admin_error_message_path(error_message), :method => :delete, :data => {:confirm => "Are you sure?"}
    end
  end
end
