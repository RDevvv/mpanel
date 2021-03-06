class HomeController < ApplicationController
    layout 'listing'
    respond_to :html, :json

    before_filter :get_referer, :only => [:index]

    def get_referer
        request.env["rack.session"]["referer"].first[:base_url]
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

    def index
    end

    def outlet_listing
        @location = Outlet.get_coordinates(params[:location],params[:longitude], params[:latitude])
        CustomerSession.update_coordinates(cookies[:customer_uuid], @location)
        @outlets = Outlet.new(:latitude => @location[:latitude], :longitude => @location[:longitude]).nearbys(5, :units => :km)

        if !@outlets.nil?&&params[:search]=='all'
            @outlets = @outlets.page(params[:page])
        end

        if session[:brands].nil?||session[:location]!=params[:location]||params[:page]=='1'
            session[:location] = params[:location]
            session[:brands] = Hash.new
        end

        unless @outlets.blank?
          if request.env['SERVER_NAME'] == 'api.shoffr.com' || request.env['SERVER_NAME'] == 'localhost'
            @outlets = @outlets.where(:is_active => true).includes({:account_brand => [:brand => :attachments]}, {:ads => [:ad_promocodes]}, {:area => [:city]})
          else
            account_brand_ids = Account.find(params[:account_id]).account_brands.map{|ab|ab.id}
            @outlets = @outlets.where(:is_active => true, :account_brand_id => account_brand_ids).includes({:account_brand => [:brand => :attachments]}, {:ads => [:ad_promocodes]}, {:area => [:city]})
          end

          if params[:search] != 'all'
            result = Keyword.search(params[:search])
            @outlets, @ad_ids = Outlet.sort_by_distance_and_presence(result,@outlets)
          end
          @outlets = Outlet.where(:id => 0) if @outlets.blank?
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
