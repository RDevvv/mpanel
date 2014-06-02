class ApplicationController < ActionController::Base
    protect_from_forgery
    layout :set_layout

    before_filter :set_headers

    def set_headers
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
        response.headers['Access-Control-Request-Method'] = '*'
        response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
        response.headers['Accept-Encoding'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end

    def user_for_paper_trail
        if current_admin_user
            current_admin_user
        else
            'Unknown User'
        end
        admin_user_signed_in? ? current_admin_user : 'Unknown user'
    end

    def after_sign_in_path_for(resource)
        # IF it's merchant redirect to merchant page
        if resource.is_a?(User)
            merchant_merchants_path
        else
            super
        end
    end
    private

    def set_layout
        if devise_controller? && devise_mapping.name == :merchant_user
            "merchant"
        elsif controller_name == 'campaigns' || controller_name == 'customers' || controller_name == 'ads'
            "home_index"
        else
            "application"
        end
    end

    rescue_from CanCan::AccessDenied do |exception|
        flash[:error] = "Access denied."
        redirect_to root_url
    end
end
