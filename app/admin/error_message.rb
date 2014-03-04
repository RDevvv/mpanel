ActiveAdmin.register ErrorMessage do
    controller do
        def scoped_collection
            p params
            if params[:error_type].blank?
                ErrorMessage.where("class_name not like '%RoutingError%' and class_name not like '%StatementInvalid%' and class_name not like '%Template::Error%'")
            else
                ErrorMessage.where("class_name like '%#{params[:error_type]}%'")
            end
        end
    end

    menu :parent => "System"
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
