class Merchant::OutletsController <  Merchant::BaseController
  before_filter  :load_account
	before_filter  :load_account_and_brand

	def index
    @outlets = @account_brand.outlets
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
    if !Area.find_by_area_name(params[:area_name].downcase).present?
      @area = Area.new(:city_id=>params[:city_id], :area_name=>params[:area_name].downcase)
      @area.save
      @outlet = @account_brand.outlets.new(params[:outlet])
      @outlet.area = @area
    else
  		@outlet = @account_brand.outlets.new(params[:outlet])
    end
    respond_to do |format|
      if @outlet.save
        format.html { redirect_to merchant_account_account_brand_path(@current_account,@account_brand),:notice=>"Outlet Succesfully Added"}
      else
        format.html { render action: "new" }
      end
    end
	end

	def import
    @csv_records,@file = Outlet.show_records(params[:file])
    @valid_records, @invalid_records = Outlet.import(params[:file],params[:account_brand_id])
  end

 	def edit
		@outlet = @account_brand.outlets.find(params[:id])	
    @cities = City.order("city_name")
    @areas =[]
	end

	def update
		@outlet = @account_brand.outlets.find(params[:id])
    respond_to do |format|
      if @outlet.update_attributes(params[:outlet])
        format.html { redirect_to merchant_account_account_brand_outlets_path(@current_account,@account_brand),:notice=>"Outlet Succesfully Updated" }
      else
        format.html { render action: "edit" }
      end
    end
	end

	def destroy
    @outlet = @account_brand.outlets.find(params[:id])
    @outlet.destroy
    respond_to do |format|
    	format.html { redirect_to merchant_account_account_brand_outlets_path(@current_account,@account_brand),:notice=>"Outlet Succesfully Destoyed"}
    end
	end

  def show
    @outlet = @account_brand.outlets.find(params[:id])
    @area = @outlet.area
    @city = @area.city
    @country = @city.state.country
    area_location = Test.new
    puts area_location.get_area(@area, @city, @country)
  end

	protected
	def load_account_and_brand
		@account_brand = @current_account.account_brands.find(params[:account_brand_id])
	end

end