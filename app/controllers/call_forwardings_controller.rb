class CallForwardingsController < ApplicationController
  def index
    @call_forwardings = CallForwarding.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @call_forwardings }
    end
  end

  def show
    @call_forwarding = CallForwarding.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @call_forwarding }
    end
  end

  def get_customer_number
    sid="gullakmaster"
    token="449df2572ff8b57017ceb975d5dc15b93d480e02"
    @call_forwarding = CallForwarding.create(:call_sid=>params["CallSid"],:from=>params[:From],:to=>params["To"],:direction=>params["Direction"],:dial_call_duration=>params["DialCallDuration"],:start_time=>params["StartTime"],:end_time=>params["EndTime"], :call_type=>params["CallType"],:digits=>params["digits"])
    render :text => 'OK', :status => '200'
    #@call_forwarding.compare_call_forwarding_number_with_exotel
  end

  def return_outlet_number
      outlet = CallForwarding.where(:call_sid=> params[:CallSid]).last.customer.button_clicks.where(:button_class => "call").last.outlet

      respond_to do |format|
          format.json {render json: "0#{mobile_number}" }
      end
  end

  def store_call_details
      customer = Customer.where(:uuid => params[:customer_uuid]).first
      customer_session  = customer.customer_sessions.last
      agent = request.env['HTTP_REFERER']

      CallForwarding.create(:customer_id => customer.id, :ad_id => params[:ad_id], :outlet_id => params[:outlet_id], :session_id => customer_session.id)

      respond_to do |format|
          format.json {render :nothing => true}
      end
  end
end
