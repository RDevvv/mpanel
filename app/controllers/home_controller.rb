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
            customer = Customer.where(:uuid => cookies[:customer_uuid]).first
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
        @outlets = nil
        location = Outlet.get_coordinates(params[:location],params[:longitude], params[:latitude])
        CustomerSession.update_coordinates(cookies[:customer_uuid], location)
        @outlets = Outlet.new(:latitude => location[:latitude], :longitude => location[:longitude]).nearbys(5, :units => :km)
        @final_outlets = Outlet.sort_outlet_by_ad_presence(@outlets)
        #@final_outlets = Kaminari.paginate_array(@final_outlets).page(params[:page]).per(5)
    end

    def share_listing
        @outlets = nil
        location = Outlet.get_coordinates(params[:location],params[:longitude], params[:latitude])
        CustomerSession.update_coordinates(cookies[:customer_uuid], location)
        @outlets = Outlet.new(:latitude => location[:latitude], :longitude => location[:longitude]).nearbys(5, :units => :km)
        @shared_outlets = Category.where(:category_name => params[:category]).first.brands.map{|b|b.account_brands}.flatten.map{|ab|ab.ads}.flatten.uniq.map{|ad|ad.account_brand}.map{|ab|ab.outlets}.flatten.map{|outlet|outlet.id}

        unless @outlets.blank?
            @nearby_outlets = @outlets.map{|o| o.id}.uniq
        else
            @nearby_outlets = []
        end

        @new_outlets = Outlet.where(:id => 0)
        nearby_outlets_with_ad = @shared_outlets&@nearby_outlets
        unless nearby_outlets_with_ad.empty?
            nearby_outlets_with_ad.each do |outlet_id|
                @new_outlets.append(@outlets.find(outlet_id))
            end
        end
        @final_outlets = @new_outlets.sort {|x,y| x.distance <=> y.distance}
        @final_outlets = @final_outlets.uniq
    end

    def brand_listing
        #@final_outlets = Brand.find(params[:brand_id]).sort_by_brands
    end

    def map_listing
        @location = Outlet.get_coordinates(params[:location],params[:longitude], params[:latitude])
        CustomerSession.update_coordinates(cookies[:customer_uuid], @location)

        @outlets = Outlet.new(:latitude => @location[:latitude], :longitude => @location[:longitude]).nearbys(5, :units => :km)
        @final_outlets = Outlet.sort_outlet_by_ad_presence(@outlets)
        #@final_outlets = Kaminari.paginate_array(@final_outlets).page(params[:page]).per(5)
    end

    def refered_listing
        #@refered_ad = Outlet.find(params[:id1])
    end

    def outlet_search
        location = Outlet.get_coordinates(params[:location],params[:longitude], params[:latitude])
        result = Keyword.search(params[:search])
        CustomerSession.update_coordinates(cookies[:customer_uuid], location)

        @outlets = Outlet.new(:latitude => location[:latitude], :longitude => location[:longitude]).nearbys(5, :units => :km)
        unless @outlets.blank?
            @nearby_outlets = @outlets.map{|o| o.id}.uniq
        else
            @nearby_outlets = []
        end


        unless result.blank?
            @ads = Ad.where(:id => 0) #cheap way of initializing a ActiveRecord::Relation
            @new_outlets = Outlet.where(:id => 0)
            result.each do |ad|
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
            @final_outlets = @final_outlets.uniq
        end
        unless result.blank?
            @ad_ids = result.map{|ad|ad.id}
        end
        #render "outlet_listing"
    end

    def map_search
        @location = Outlet.get_coordinates(params[:location],params[:longitude], params[:latitude])
        result = Keyword.search(params[:search])

        CustomerSession.update_coordinates(cookies[:customer_uuid], @location)
        @outlets = Outlet.new(:latitude => @location[:latitude], :longitude => @location[:longitude]).nearbys(5, :units => :km)
        unless @outlets.blank?
            @nearby_outlets = @outlets.map{|o| o.id}.uniq
        else
            @nearby_outlets = []
        end


        unless result.blank?
            @ads = Ad.where(:id => 0) #cheap way of initializing a ActiveRecord::Relation
            @new_outlets = Outlet.where(:id => 0)
            result.each do |ad|
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

    def combo_view
    end

    def admin_panel
    end
end
