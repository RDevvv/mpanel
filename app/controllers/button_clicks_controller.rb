class ButtonClicksController < ApplicationController
    def get_click
        customer = Customer.where(:uuid => params[:customer_uuid]).first
        customer_session  = CustomerSession.where(:customer_id => customer.id).last
        agent = request.env['HTTP_REFERER']
        ButtonClick.create(:customer_id => customer.id, :button_class => params[:button_class], :previous_link => agent, :current_link => params[:current_link], :ad_id => params[:ad_id], :outlet_id => params[:outlet_id], :customer_session_id => customer_session.id)

        respond_to do |format|
            format.json {render :nothing => true, :status => 200, :content_type => 'text/html'}
        end
    end
end
