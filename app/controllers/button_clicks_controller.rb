class ButtonClicksController < ApplicationController
    def get_click
        customer = Customer.where(:uuid => params[:customer_uuid]).first
        customer_session  = CustomerSession.where(:customer_id => customer.id).last
        agent = request.env['HTTP_REFERER']

        ButtonClick.create(:customer_id => customer.id, :button_class => params[:button_class], :previous_link => agent, :current_link => params[:current_link], :ad_id => params[:ad_id], :outlet_id => params[:outlet_id], :customer_session_id => customer_session.id)

        respond_to do |format|
            format.json {render :nothing => true}
        end
    end

    def index
        @button_clicks = ButtonClick.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @button_clicks }
        end
    end

    # DELETE /button_clicks/1
    # DELETE /button_clicks/1.json
    def destroy
        @button_click = ButtonClick.find(params[:id])
        @button_click.destroy

        respond_to do |format|
            format.html { redirect_to button_clicks_url }
            format.json { head :no_content }
        end
    end
end
