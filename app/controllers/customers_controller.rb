class CustomersController < ApplicationController
  # GET /customers
  # GET /customers.json
  def index
    @customers = Customer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @customers }
    end
  end

  # GET /customers/1
  # GET /customers/1.json
  def show
    @customer = Customer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/new
  # GET /customers/new.json
  def new
    @customer = Customer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  # GET /customers/1/edit
  def edit
    @customer = Customer.find(params[:id])
  end

  # POST /customers
  # POST /customers.json
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        format.html { redirect_to @customer, notice: 'Customer was successfully created.' }
        format.json { render json: @customer, status: :created, location: @customer }
      else
        format.html { render action: "new" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /customers/1
  # PUT /customers/1.json
  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        format.html { redirect_to @customer, notice: 'Customer was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @customer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customers/1
  # DELETE /customers/1.json
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to customers_url }
      format.json { head :no_content }
    end
  end

  def verify_mobile_number
    @customer = Customer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @customer }
    end
  end

  def check_verification_code
      @customer = Customer.where(:uuid => cookies[:customer_uuid]).first
      if @customer.is_verified == true
          @customer.errors.add(:already_verified, "This phone number is already verified")
      elsif @customer.verification_code == (params[:customer][:verification_code])
          @customer.update_attributes(:is_verified => true)
          flash[:notice] = "We've successfully verified your phone number"
          redirect_to :root
      else
          @customer.errors.add(:verification_code, "Enter correct verification code")
          redirect_to :verify_mobile_number
      end
  end

  def get_mobile_number
      @customer = Customer.where(:uuid => params[:customer_uuid]).first
      @all_customers = Customer.all
      if @all_customers.map{|c| c.mobile_number}.uniq.include?(params[:mobile_number].to_i)
          @existing_customer = Customer.where(:mobile_number => params[:mobile_number]).first
          cookies[:customer_uuid] = @existing_customer.uuid
      else
          @customer.update_attributes(:mobile_number => params[:mobile_number]) unless params[:mobile_number].empty?
      end
      respond_to do |format|
          format.json { render :nothing => true}
      end
  end
end
