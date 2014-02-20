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
            referer_agent = request.env['HTTP_REFERER']
            parsed_agent = UserAgent.parse(agent)
            campaign_url = request.env['HTTP_HOST']+request.env['ORIGINAL_FULLPATH']
            customer = Customer.includes(:customer_sessions).where(:uuid => cookies[:customer_uuid]).first
            unless customer.blank?
                customer_id = customer.id
                if customer.mobile_number.nil?
                    cookies[:mobile_number] = {:value => false, :expires => 1.year.from_now}
                else
                    cookies[:mobile_number] = {:value => true, :expires => 1.year.from_now}
                end
                CustomerSession.create(:campaign_url => campaign_url, :referer_link => referer_agent, :customer_id => customer_id, :browser_version => parsed_agent.version, :platform => parsed_agent.platform, :browser => parsed_agent.browser)
                session[:customer_id] = customer_id
            end
        end
    end

    def get_referer
        request.env["rack.session"]["referer"].first[:base_url]
    end

    def index
    end

    def outlet_listing
        location = Outlet.get_coordinates(params[:location],params[:longitude], params[:latitude])
        CustomerSession.update_coordinates(cookies[:customer_uuid], location)
        @outlets = Outlet.new(:latitude => location[:latitude], :longitude => location[:longitude]).nearbys(5, :units => :km).includes({:account_brand => [:brand => :attachments]}, :ads, {:area => [:city]})
        @outlets = Outlet.discard_outlets_from_same_brand(@outlets)
        @final_outlets = Outlet.sort_outlet_by_ad_presence(@outlets)
        #@final_outlets = Kaminari.paginate_array(@final_outlets).page(params[:page]).per(10)
    end

    def map_listing
        @location = Outlet.get_coordinates(params[:location],params[:longitude], params[:latitude])
        CustomerSession.update_coordinates(cookies[:customer_uuid], @location)

        @outlets = Outlet.new(:latitude => @location[:latitude], :longitude => @location[:longitude]).nearbys(5, :units => :km).where(:is_active => true).includes({:account_brand => [:brand => :attachments]}, :ads, {:area => [:city]})


        @outlets = Outlet.discard_outlets_from_same_brand(@outlets)
        @final_outlets = Outlet.sort_outlet_by_ad_presence(@outlets)
        @map_outlets = Array.new
        @pin_id = 0
        #@final_data = Outlet.generate_ad_outlet(@final_outlets)
        #@final_outlets = Kaminari.paginate_array(@final_outlets).page(params[:page]).per(5)
    end

    def share_listing
        location = Outlet.get_coordinates(params[:location],params[:longitude], params[:latitude])
        CustomerSession.update_coordinates(cookies[:customer_uuid], location)
        @outlets = Outlet.new(:latitude => location[:latitude], :longitude => location[:longitude]).nearbys(5, :units => :km).where(:is_active => true)
        @shared_outlets = Category.where(:category_name => params[:category].gsub("_"," ")).first.brands.map{|b|b.account_brands}.flatten.map{|ab|ab.ads}.flatten.uniq.map{|ad|ad.account_brand}.map{|ab|ab.outlets}.flatten.map{|outlet|outlet.id}

        @nearby_outlets = Outlet.nearby_outlet_ids(@outlets)

        @new_outlets = Outlet.where(:id => 0)
        nearby_outlets_with_ad = @shared_outlets&@nearby_outlets
        unless nearby_outlets_with_ad.empty?
            nearby_outlets_with_ad.each do |outlet_id|
                @new_outlets.append(@outlets.find(outlet_id))
            end
        end
        @final_outlets = @new_outlets.sort {|x,y| x.distance <=> y.distance}.uniq
    end

    def outlet_search
        location = Outlet.get_coordinates(params[:location],params[:longitude], params[:latitude])
        result = Keyword.search(params[:search])
        CustomerSession.update_coordinates(cookies[:customer_uuid], location)

        outlets = Outlet.new(:latitude => location[:latitude], :longitude => location[:longitude]).nearbys(5, :units => :km)
        @final_outlets, @ad_ids = Outlet.sort_by_distance_and_presence(result,outlets)
    end

    def map_search
        @location = Outlet.get_coordinates(params[:location],params[:longitude], params[:latitude])
        result = Keyword.search(params[:search])

        CustomerSession.update_coordinates(cookies[:customer_uuid], @location)
        outlets = Outlet.new(:latitude => @location[:latitude], :longitude => @location[:longitude]).nearbys(5, :units => :km).limit(20)

        @final_outlets,@ad_ids = Outlet.sort_by_distance_and_presence(result,outlets)
    end

    def hot_picks
        @ads = Ad.where(:id => 0)
        location = Outlet.get_coordinates(params[:location],params[:longitude], params[:latitude])
        CustomerSession.update_coordinates(cookies[:customer_uuid], location)

        @outlets = Outlet.new(:latitude => location[:latitude], :longitude => location[:longitude]).nearbys(5, :units => :km)
        @nearby_outlet_ids = @outlets.map{|o|o.id}

        @hot_picks = @outlets.map{|outlet|outlet.ads}.flatten.sort{|x,y|y.usage <=> x.usage}.flatten.uniq
        @hot_picks_outlet_ids = @hot_picks.map{|ad|ad.outlets}.flatten.uniq.map{|o|o.id}

        @final_outlets = @nearby_outlet_ids&@hot_picks_outlet_ids

        @new_outlets = Outlet.where(:id => 0)
        @final_outlets.each do |outlet_id|
            @new_outlets.append(@outlets.find(outlet_id))
        end
        @final_outlets = @new_outlets

        #@final_outlets = Kaminari.paginate_array(@final_outlets).page(params[:page]).per(5)
        render "outlet_listing"
    end
end
