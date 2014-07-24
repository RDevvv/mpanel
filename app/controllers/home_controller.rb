class HomeController < ApplicationController
    layout 'listing'
    respond_to :html, :json


    def get_referer
        request.env["rack.session"]["referer"].first[:base_url]
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
            @outlets = @outlets.where(:is_active => true).includes({:account_brand => [:brand => :attachments]}, {:ads => [:ad_promocodes]}, {:area => [:city]})
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
