class ButtonClicksController < ApplicationController
    before_filter :set_headers
    skip_before_filter  :verify_authenticity_token, :only => [:get_click]

    def set_headers
        response.headers['Access-Control-Allow-Origin'] = '*'
        response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
        response.headers['Access-Control-Request-Method'] = '*'
        response.headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
        response.headers['Accept-Encoding'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    end

    def get_click
        customer = Customer.where(:uuid => params[:customer_uuid]).first
        customer_session  = CustomerSession.where(:customer_id => customer.id)
        if customer_session.nil?
            customer_session = CustomerSession.create(:customer_id => customer.id)
        else
            customer_session = customer_session.last
        end

        agent = request.env['HTTP_REFERER']
        ButtonClick.create(:customer_id => customer.id, :button_class => params[:button_class], :previous_link => agent, :current_link => params[:current_link], :ad_id => params[:ad_id], :outlet_id => params[:outlet_id], :customer_session_id => customer_session.id)

        respond_to do |format|
            format.json {render :nothing => true, :status => 200, :content_type => 'text/html'}
        end
    end
end
