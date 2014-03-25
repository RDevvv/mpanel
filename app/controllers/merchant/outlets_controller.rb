class Merchant::OutletsController <  Merchant::BaseController
  before_filter  :load_account
	before_filter  :load_account_and_brand, :except => [:select_outlet, :outletview_edit]
  #skip_before_filter :authenticate_merchant_user!, :only=>[:outlet_key, :outletview_edit]

	def index
    @outlets = @account_brand.outlets
    @outlets.each do|outlet|
      outlet.is_outlet_verified
    end
		@brands = Brand.all
		@cities = City.all
    respond_to do |format|
      format.html # index.html.erb
    end		
	end

	def new
		@outlet = @account_brand.outlets.new
		@brands = Brand.all
		@cities = City.order("city_name")
		@areas = []
		respond_to do |format|
      format.html # new.html.erb
    end
	end

	def populate_areas
    # @areas = Area.find( :all, :conditions => [" city_id = ?", params[:id]]  ).sort_by{ |k| k['area_name'] } 
    @areas = Area.where(:city_id=>params[:city_id]).order(:area_name)
  end

	def create
    @outlet = @account_brand.outlets.new(params[:outlet])  
    @area = Area.by_area_name(params[:area_name].squish.titlecase).by_pincode(params[:pincode]).first
    @area = Area.create!(:city_id=>params[:city_id], :area_name=>params[:area_name].squish.titlecase,:pincode=>params[:pincode]) if @area.blank?
    @outlet.area = @area
    @outlet.is_active = true
    
    respond_to do |format|
      if @outlet.save
        format.html { redirect_to merchant_account_account_brand_path(@current_account,@account_brand),:notice=>"Outlet Succesfully Added"}
      else
        @brands = Brand.all
        @cities = City.order("city_name")

        format.html { render action: "new" }
      end
    end
	end

  def download_outlet_template
    send_file "#{Rails.root}/public/outlet_template.csv"
  end

  def upload_outletsm
    
  end

	def import
    @records  = Outlet.show_records(params[:file],@account_brand.id)
    @cities = City.order("city_name")
    #@valid_records, @invalid_records = Outlet.import(params[:file],params[:account_brand_id])
  end

  def import_record
    
    params[:account_brand_id] = @account_brand.id

    set_error_for_outlet_record(params)
    if @errors.blank?
      outlet = Outlet.import_record(params)
      @errors.merge!(outlet.errors.messages)
      render :json=>{:success=>outlet.valid?,:errors=>@errors,:row_id=>params[:row_id]}
    else
      render :json=>{:success=>false,:errors=>@errors,:row_id=>params[:row_id]}
    end  
    # redirect_to merchant_account_account_brand_path(@current_account,@account_brand),:notice=>"Succesfully imported records"
    
  end

 	def edit
    @outlet = @account_brand.outlets.find(params[:id])	
    @cities = City.order("city_name")
    @areas =[]
	end

	def update
    @outlet = @account_brand.outlets.find(params[:id])
    @area = Area.by_area_name(params[:area_name].squish.titlecase).by_pincode(params[:pincode]).first
    @area = Area.create!(:city_id=>params[:city_id], :area_name=>params[:area_name].squish.titlecase,:pincode=>params[:pincode]) if @area.blank?
    if @area.city_id != params[:city_id]
      @area.update_attributes(:city_id=>params[:city_id])
    end    
    params[:outlet][:area_id] = @area.id
    respond_to do |format|
      if @outlet.update_attributes(params[:outlet])
        format.html { redirect_to merchant_account_account_brand_path(@current_account,@account_brand),:notice=>"Outlet Succesfully Updated" }
      else
        @cities = City.order("city_name")
        @brands = Brand.all

        format.html { render action: "edit" }
      end
    end
	end

	def destroy
    @outlet = @account_brand.outlets.find(params[:id])
    @outlet.destroy
    respond_to do |format|
    	format.html { redirect_to merchant_account_account_brand_path(@current_account,@account_brand),:notice=>"Outlet Succesfully Destoyed"}
    end
	end

  def show
    @outlet = @account_brand.outlets.find(params[:id])
    @area = @outlet.area
    @city = @area.city
  end

  def toggle_active
    @outlet = @account_brand.outlets.find(params[:id])
    @outlet.toggle_active
    redirect_to merchant_account_account_brand_path(@current_account,@account_brand)
  end

  def toggle_active_index
    @outlet = @account_brand.outlets.find(params[:id])
    @outlet.toggle_active
    redirect_to merchant_account_account_brand_outlets_path(@current_account,@account_brand)
  end
 
  def toggle_verify
    @outlet = @account_brand.outlets.find(params[:id])
    @outlet.toggle_verify
    redirect_to merchant_account_account_brand_ad_ad_group_path(@current_account,@account_brand,@ad,@ad_group)
  end

  def outlet_key
    render layout: "outlet_manager"
  end

  def outletview_edit
    @outlet = Outlet.where(:outlet_key => params[:outlet_key]).first
    @cities = City.order("city_name")
    @areas =[]
    render layout: "outlet_manager"
  end

  def select_outlet
    @cities = City.order("city_name")
    @areas = Area.all
    @outlet = Outlet.all
    render layout: "outlet_manager"
  end

	protected
  
  def set_error_for_outlet_record(params)
    @errors = {}
    @errors[:pincode]= ["can't be blank"] if params[:pincode].blank?
    @errors[:area_name]= ["can't be blank"] if params[:area_name].blank?
    @errors[:pincode] = Array(@errors[:pincode]).push("is not valid") if params[:pincode].present? && params[:pincode].length !=6
  end

	def load_account_and_brand
		@account_brand = @current_account.account_brands.find(params[:account_brand_id])
  end

end
