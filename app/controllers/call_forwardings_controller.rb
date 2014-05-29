class CallForwardingsController < ApplicationController
  layout "outlet_manager", :only => [:outletview_call_log]
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
  end

  def return_outlet_number
      outlet = CallForwarding.where(:call_sid=> params[:CallSid]).order(:id).last.customer.button_clicks.where(:button_class => "call").order(:id).last.outlet
      if outlet.phone_number.blank?
          number = outlet.mobile_number
      else
          number = outlet.phone_number
      end

      respond_to do |format|
          format.json {render json: number }
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

  def outletview_call_log
    @call_forwardings = CallForwarding.where(:outlet_id => params[:id]).all
  end

end
