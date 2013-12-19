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
		@areas =[]
		# @outlets = @account_brand.outlets.pluck(:outlet_name)
		respond_to do |format|
      format.html # new.html.erb
    end
	end

	def populate_areas
    # @city = city.find(params[:city])
    # @areas = @city.areas
    # @areas = Area.find( :all, :conditions => [" city_id = ?", params[:id]]  ).sort_by{ |k| k['area_name'] } 
    @areas = Area.where(:city_id=>params[:city_id]).order(:area_name)
    
  end

	def create	
		@outlet = @account_brand.outlets.new(params[:outlet])
    respond_to do |format|
      if @outlet.save
        format.html { redirect_to merchant_account_account_brand_path(@current_account,@account_brand),:notice=>"Outlet Succesfully Added"}
      else
        format.html { render action: "new" }
      end
    end
	end

	def import
    invalid_records = Outlet.import(params[:file])
    redirect_to merchant_account_account_brand_outlets_path(@current_account,@account_brand), notice: "Outlets imported."
  end

	def edit
		@outlet = @account_brand.outlets.find(params[:id])	
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

	protected
	def load_account_and_brand
		@account_brand = @current_account.account_brands.find(params[:account_brand_id])
	end

end