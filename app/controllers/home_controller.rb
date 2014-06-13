class HomeController < ApplicationController
    layout 'listing'
    respond_to :html, :json

    before_filter :check_cookies, :except => [:check_app_cookies]
    before_filter :record_session
    before_filter :get_referer, :only => [:index]

    def check_cookies
        if cookies[:customer_uuid].blank?
            cookies[:customer_uuid] = {:value => Customer.generate_cookie, :expires => 1.year.from_now}
            @customer = Customer.create(:uuid => cookies[:customer_uuid])
        end
    end

    def check_app_cookies
        params[:customer_uuid] = nil if params[:customer_uuid] == 'undefined'
        if params[:customer_uuid].blank?
            @customer = Customer.create(:uuid => Customer.generate_cookie)
        else
            @customer = Customer.where(:uuid => params[:customer_uuid]).first
        end
        return @customer
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
                CustomerSession.create(:campaign_url => campaign_url, :referer_link => referer_agent, :customer_id => customer.id, :browser_version => parsed_agent.version, :platform => parsed_agent.platform, :browser => parsed_agent.browser)
                session[:customer_id] = customer.id
            end
        end
    end

    def get_referer
        request.env["rack.session"]["referer"].first[:base_url]
    end

    def index
    end

    def outlet_listing
        @location = Outlet.get_coordinates(params[:location],params[:longitude], params[:latitude])
        CustomerSession.update_coordinates(cookies[:customer_uuid], @location)
        @outlets = Outlet.new(:latitude => @location[:latitude], :longitude => @location[:longitude]).nearbys(5, :units => :km).page(params[:page])
        if session[:brands].nil?||session[:location]!=params[:location]
            session[:location] = params[:location]
            session[:brands] = Hash.new
        end

        unless @outlets.blank?
            @outlets = @outlets.where(:is_active => true).includes({:account_brand => [:brand => :attachments]}, {:ads => [:ad_promocodes]}, {:area => [:city]})
            if params[:search] != 'all'
                result = Keyword.search(params[:search])
                @outlets, @ad_ids = Outlet.sort_by_distance_and_presence(result,@outlets)
            end
            @outlets, session[:brands]= Outlet.discard_outlets_from_same_brand(@outlets, session[:brands])
            @final_outlets = Outlet.sort_outlet_by_ad_presence(@outlets)
            @poster_data = Outlet.get_poster_data(@final_outlets, cookies[:customer_uuid])
        end
    end

    def no_results
        @current_session_id = Customer.where(:uuid => cookies[:customer_uuid]).first.customer_sessions.first.id
    end

    def location_not_found
        @current_session_id = Customer.where(:uuid => cookies[:customer_uuid]).first.customer_sessions.first.id
    end
end
