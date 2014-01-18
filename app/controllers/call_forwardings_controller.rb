class CallForwardingsController < ApplicationController
  # GET /call_forwardings
  # GET /call_forwardings.json
  def index
    @call_forwardings = CallForwarding.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @call_forwardings }
    end
  end

  # GET /call_forwardings/1
  # GET /call_forwardings/1.json
  def show
    @call_forwarding = CallForwarding.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @call_forwarding }
    end
  end

  # GET /call_forwardings/new                                               
  # GET /call_forwardings/new.json
  def new
    @call_forwarding = CallForwarding.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @call_forwarding }
    end
  end

  # GET /call_forwardings/1/edit
  def edit
    @call_forwarding = CallForwarding.find(params[:id])
  end

  # POST /call_forwardings
  # POST /call_forwardings.json
  def create
    @call_forwarding = CallForwarding.new(params[:call_forwarding])

    respond_to do |format|
      if @call_forwarding.save
        format.html { redirect_to @call_forwarding, notice: 'Call forwarding was successfully created.' }
        format.json { render json: @call_forwarding, status: :created, location: @call_forwarding }
      else
        format.html { render action: "new" }
        format.json { render json: @call_forwarding.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /call_forwardings/1
  # PUT /call_forwardings/1.json
  def update
    @call_forwarding = CallForwarding.find(params[:id])

    respond_to do |format|
      if @call_forwarding.update_attributes(params[:call_forwarding])
        format.html { redirect_to @call_forwarding, notice: 'Call forwarding was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @call_forwarding.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /call_forwardings/1
  # DELETE /call_forwardings/1.json
  def destroy
    @call_forwarding = CallForwarding.find(params[:id])
    @call_forwarding.destroy

    respond_to do |format|
      format.html { redirect_to call_forwardings_url }
      format.json { head :no_content }
    end
  end

  def get_customer_number
    sid="gullakmaster"
    token="449df2572ff8b57017ceb975d5dc15b93d480e02"
    @call_forwarding = CallForwarding.create(:call_sid=>params["CallSid"],:from=>params["From"],:to=>params["To"],:direction=>params["Direction"],:dial_call_duration=>params["DialCallDuration"],:start_time=>params["StartTime"],:end_time=>params["EndTime"], :call_type=>params["CallType"],:digits=>params["digits"])
    render :text => 'OK', :status => '200'
    #@call_forwarding.compare_call_forwarding_number_with_exotel
  end

  def get_outlet_number
    redirect_to :action => "set_outlet_number", :format => :json, :To => "09504454594"
  end

  def set_outlet_number
    respond_to do |format|
      format.json {render :nothing => true}
    end
  end

  def return_outlet_number
      mobile_number = CallForwarding.where(:call_sid=> params[:CallSid]).last.customer.button_clicks.where(:button_class => "call").last.outlet.mobile_number

      respond_to do |format|
          format.json {render json: mobile_number}
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
