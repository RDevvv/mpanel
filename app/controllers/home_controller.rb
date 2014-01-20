class HomeController < ApplicationController
    before_filter :check_cookies
    before_filter :record_session
    before_filter :get_referer, :only => [:index]

    def check_cookies
        if cookies[:customer_uuid].blank?
            cookies[:customer_uuid] = {:value => Customer.generate_cookie, :expires => 1.year.from_now}
            Customer.create(:uuid => cookies[:customer_uuid])
        end
    end

    def record_session
        unless session[:new_session] == 1
            session[:new_session] = 1
            agent = request.env['HTTP_USER_AGENT']
            puts referer_agent = request.env['HTTP_REFERER']
            parsed_agent = UserAgent.parse(agent)
            customer = Customer.where(:uuid => cookies[:customer_uuid]).first
            customer_id = customer.id
            if customer.mobile_number.nil?
                cookies[:mobile_number] = {:value => false, :expires => 1.year.from_now}
            else
                cookies[:mobile_number] = {:value => true, :expires => 1.year.from_now}
            end
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

        r = Keyword.search do
            fulltext params[:search]
        end

        Customer.where(:uuid =>cookies[:customer_uuid]).first.customer_sessions.last.update_attributes(:latitude => latitude, :longitude => longitude)
        @outlets = Outlet.new(:latitude => latitude, :longitude => longitude).nearbys(5, :units => :km)
        unless @outlets.empty?
            @nearby_outlets = @outlets.map{|o| o.id}.uniq
        else
            @nearby_outlets = []
        end


        unless r.results.first.nil?
            @ads = Ad.where(:id => 0) #cheap way of initializing a ActiveRecord::Relation
            @new_outlets = Outlet.where(:id => 0)
            r.results.first.ads.each do |ad|
                unless ad.outlets.empty?
                    ad_outlets = ad.outlets.map{|outlet| outlet.id}.uniq
                    nearby_outlets_with_ad = ad_outlets&@nearby_outlets
                    unless nearby_outlets_with_ad.empty?
                        nearby_outlets_with_ad.each do |outlet_id|
                            @new_outlets.append(@outlets.find(outlet_id))
                        end
                        @ads.append(Ad.find(ad.id))
                    end
                end
            end
        @final_outlets = @new_outlets.sort {|x,y| x.distance <=> y.distance}
        end
    end

    def hot_picks
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

        @outlets = Outlet.new(:latitude => latitude, :longitude => longitude).nearbys(5, :units => :km)
        @outlets.each do |outlet|
            if outlet.is_active?
                #@hot_picks = @outlets.map{|outlet|outlet.ads}.flatten.map{|ad|ad.ad_promocodes.first}.flatten.sort{|ad_promocode|ad_promocode.usage}reverse.map{|ad_promocode|ad_promocode.ad}
            end
        end
        @final_outlets = @ads
        #@final_outlets = Kaminari.paginate_array(@final_outlets).page(params[:page]).per(5)
    end
end
