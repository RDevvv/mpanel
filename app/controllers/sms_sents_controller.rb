class SmsSentsController < ApplicationController
  # GET /sms_sents
  # GET /sms_sents.json
  def index
    @sms_sents = SmsSent.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sms_sents }
    end
  end

  # GET /sms_sents/1
  # GET /sms_sents/1.json
  def show
    @sms_sent = SmsSent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sms_sent }
    end
  end

  # GET /sms_sents/new
  # GET /sms_sents/new.json
  def new
    @sms_sent = SmsSent.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sms_sent }
    end
  end

  # GET /sms_sents/1/edit
  def edit
    @sms_sent = SmsSent.find(params[:id])
  end

  # POST /sms_sents
  # POST /sms_sents.json
  def create
    @sms_sent = SmsSent.new(params[:sms_sent])

    respond_to do |format|
      if @sms_sent.save
        format.html { redirect_to @sms_sent, notice: 'Sms sent was successfully created.' }
        format.json { render json: @sms_sent, status: :created, location: @sms_sent }
      else
        format.html { render action: "new" }
        format.json { render json: @sms_sent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sms_sents/1
  # PUT /sms_sents/1.json
  def update
    @sms_sent = SmsSent.find(params[:id])

    respond_to do |format|
      if @sms_sent.update_attributes(params[:sms_sent])
        format.html { redirect_to @sms_sent, notice: 'Sms sent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sms_sent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms_sents/1
  # DELETE /sms_sents/1.json
  def destroy
    @sms_sent = SmsSent.find(params[:id])
    @sms_sent.destroy

    respond_to do |format|
      format.html { redirect_to sms_sents_url }
      format.json { head :no_content }
    end
  end

  def set_sms_data
      customer = Customer.where(:uuid => params[:customer_uuid]).first
      unless customer.mobile_number.nil?
          ad = Ad.find(params[:ad_id])
          ad_promocode_outlet = ad.ad_promocode_outlets.where(:outlet_id => params[:outlet_id])
          @sms_sent = SmsSent.create(:text => "ad.sms_text")
          puts "if set_sms_data"
          respond_to do |format|
              format.json {render :nothing => true}
          end
      else
          puts "else set_sms_data"
              render :json => {:mobile_number_presence => false, :customer_id => customer.id}
      end
  end
end
