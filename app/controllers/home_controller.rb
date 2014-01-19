class HomeController < ApplicationController
    before_filter :check_cookies
    before_filter :record_session
    before_filter :get_referer, :only => [:index]

    def check_cookies
        if cookies[:customer_uuid].blank?
            cookies[:customer_uuid] = Customer.generate_cookie
            Customer.create(:uuid => cookies[:customer_uuid])
        end
    end

    def record_session
        unless session[:new_session] == 1
            session[:new_session] = 1
            agent = request.env['HTTP_USER_AGENT']
            puts referer_agent = request.env['HTTP_REFERER']
            parsed_agent = UserAgent.parse(agent)
            customer_id = Customer.where(:uuid => cookies[:customer_uuid]).first.id
            CustomerSession.create(:referer_link => referer_agent, :customer_id => customer_id, :browser_version => parsed_agent.version, :platform => parsed_agent.platform, :browser => parsed_agent.browser)
            session[:customer_id] = customer_id
        end
    end

    def get_referer
        request.env["rack.session"]["referer"].first[:base_url]
        #binding.pry
    end

    def index
    end

    def outlet_listing
        @outlets = nil
        if params[:location].nil?
            latitude = params[:latitude]
            longitude = params[:longitude]
        else
            result = Geocoder.search(params[:location]+" india")
            unless result.empty?
                @location = result.first.data["geometry"]["location"]
                latitude = @location["lat"]
                longitude = @location["lng"]
            end
        end

        Customer.where(:uuid =>cookies[:customer_uuid]).first.customer_sessions.last.update_attributes(:latitude => latitude, :longitude => longitude)
        @outlets = Outlet.new(:latitude => latitude, :longitude => longitude).nearbys(5, :units => :km)
        @final_outlets = Outlet.sort_outlet_by_ad_presence(@outlets)
        #@final_outlets = Kaminari.paginate_array(@final_outlets).page(params[:page]).per(5)
    end

    def brand_listing
        @final_outlets = Brand.find(params[:brand_id]).sort_by_brands
    end

    def map_listing
        if params[:location].nil?
            latitude = params[:latitude]
            longitude = params[:longitude]
        else
            result = Geocoder.search(params[:location]+" india")
            unless result.empty?
                @location = result.first.data["geometry"]["location"]
                latitude = @location["lat"]
                longitude = @location["lng"]
            end
        end

        Customer.where(:uuid =>cookies[:customer_uuid]).first.customer_sessions.last.update_attributes(:latitude => latitude, :longitude => longitude)
        @outlets = Outlet.new(:latitude => latitude, :longitude => longitude).nearbys(5, :units => :km)
        @final_outlets = Outlet.sort_outlet_by_ad_presence(@outlets)
        #@final_outlets = Kaminari.paginate_array(@final_outlets).page(params[:page]).per(5)
    end

    def individual_outlet
        @outlet_version = OutletVersion.find(params[:id])
    end

    def refered_listing
        #@refered_ad = Outlet.find(params[:id1])
    end

    def outlet_search
        r = Keyword.search do
            fulltext params[:search]
        end
        customer_session = Customer.where(:uuid =>cookies[:customer_uuid]).first.customer_sessions.last
        outlets = Outlet.new(:latitude => customer_session.latitude, :longitude => customer_session.latitude).nearbys(500000000, :units => :km)
        unless outlets.empty?
            nearby_outlets = outlets.map{|o| o.id}.uniq
        else
            nearby_outlets = []
        end


        unless r.results.first.ads.nil?
            @ads = Ad.where(:id => 0) #cheap way of initializing a ActiveRecord::Relation
            r.results.first.ads.each do |ad|
                unless ad.outlets.empty?
                    ad_outlets = ad.outlets.map{|outlet| outlet.id}.uniq
                    unless (ad_outlets&nearby_outlets).empty?
                        @ads.append(Ad.find(ad.id))
                    end
                end
                #binding.pry
            end

        end
    end

    def hot_picks
        latitude = 18.97
        longitude = 72.82
        @outlets = Outlet.new(:latitude => latitude, :longitude => longitude).nearbys(5, :units => :km)
        @outlets_with_ad = Array.new
        @outlets_without_ad = Array.new
        outlets_with_ad_index = 0
        outlets_without_ad_index = 0

        @outlet_ads = Array.new
        @i = 0
        @outlets.each do |outlet|
            if outlet.is_active?
                outlet.ads.each do |ad|
                    @outlet_ads[i][:ad_id] = outlet.id
                    @outlet_ads[i][:outlet_id] = outlet.outlet_id
                    @outlet_ads[i][:account_brand_id] = outlet.account_brand_id
                    @outlet_ads[i][:area_id] = outlet.area_id
                    @outlet_ads[i][:address] = outlet.address
                    @outlet_ads[i][:phone_number] = outlet.phone_number
                    @outlet_ads[i][:mobile_number] = outlet.mobile_number
                    @outlet_ads[i][:ad_title] = ad.ad_title
                    @outlet_ads[i][:sms_text] = ad.sms_text
                    i += 1
                end
            end
        end
        @final_outlets = @ads
        #@final_outlets = Kaminari.paginate_array(@final_outlets).page(params[:page]).per(5)
    end
end
