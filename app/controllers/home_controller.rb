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
            puts "within else condition => #{session[:new_session]}"
            session[:new_session] = 1
            agent = request.env['HTTP_USER_AGENT']
            parsed_agent = UserAgent.parse(agent)
            customer_id = Customer.where(:uuid => cookies[:customer_uuid]).first.id
            CustomerSession.create(:customer_id => customer_id, :browser_version => parsed_agent.version, :platform => parsed_agent.platform, :browser => parsed_agent.browser)
        end
        puts "new session ===>#{session[:new_session]}<==="
    end

    def get_referer
        request.env["rack.session"]["referer"].first[:base_url]
        #binding.pry
    end

    def index
    end

    def outlet_listing
        result = Geocoder.search(params[:location]+" india")
        unless result.empty?
            @location = result.first.data["geometry"]["location"]
            latitude = @location["lat"]
            longitude = @location["lng"]
            @outlet_versions = OutletVersion.new(:latitude => latitude, :longitude => longitude).nearbys(500, :units => :km)
        else
            @outlet_versions = nil
        end
    end

    def map_listing
        latitude = params["latitude"]
        longitude = params["longitude"]
        @outlet_versions = OutletVersion.new(:latitude => latitude, :longitude => longitude).nearbys(500, :units => :km)
    end

    def individual_outlet
        @outlet_version = OutletVersion.find(params[:id])
    end
end
