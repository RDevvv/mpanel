class ApplicationController < ActionController::Base
    protect_from_forgery
    layout :set_layout

    before_filter :set_headers
    before_filter :check_cookies
    before_filter :record_session

    def set_headers
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
        response.headers['Access-Control-Request-Method'] = '*'
        response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
        response.headers['Accept-Encoding'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end

    def check_cookies
        if cookies[:customer_uuid].blank?
            cookies[:customer_uuid] = {:value => Customer.generate_cookie, :expires => 1.year.from_now}
            @customer = Customer.create(:uuid => cookies[:customer_uuid])
        end
    end

    def record_session
        unless session[:new_session] == 1
            session[:new_session] = 1
            agent = request.env['HTTP_USER_AGENT']
            referer_agent = request.env['HTTP_REFERER']
            parsed_agent = UserAgent.parse(agent)
            campaign_url = request.env['HTTP_HOST']+request.env['ORIGINAL_FULLPATH']
            customer = Customer.includes(:customer_sessions).where(:uuid => cookies[:customer_uuid]).first
            unless customer.blank?
                if customer.mobile_number.nil?
                    cookies[:mobile_number] = {:value => false, :expires => 1.year.from_now}
                elsif customer.is_verified == true
                    cookies[:mobile_number] = {:value => 'verified', :expires => 1.year.from_now}
                end
                CustomerSession.create(:campaign_url => campaign_url, :referer_link => referer_agent, :customer_id => customer.id, :browser_version => parsed_agent.version, :platform => parsed_agent.platform, :browser => parsed_agent.browser, :customer_ip => request.ip)
                session[:customer_id] = customer.id
            end
        end
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
