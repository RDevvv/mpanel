class HomeController < ApplicationController
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
        puts " ===================>@outlet_version "
    end
end
