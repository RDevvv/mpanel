class HomeController < ApplicationController
    before_filter :check_cookies

    def check_cookies
        if cookies[:customer_uuid].blank?
            cookies[:customer_uuid] = Customer.generate_cookie
            agent = request.env['HTTP_USER_AGENT']
            parsed_agent = UserAgent.parse(agent)
            Customer.create(:uuid => cookies[:customer_uuid], :browser_version => parsed_agent.version, :platform => parsed_agent.platform, :browser => parsed_agent.browser)
        end
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
