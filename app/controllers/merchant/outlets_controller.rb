class Merchant::OutletsController <  Merchant::BaseController
	before_filter :load_account, :load_account_brand

	def index
		@outlets = @account_brand.outlets.all
		@brands = Brand.all
		@cities = City.all
    respond_to do |format|
      format.html # index.html.erb
    end		
	end

	def new
		@outlet = @account_brand.outlets.new
		@brands = Brand.all
		# @outlets = @account_brand.outlets.pluck(:outlet_name)
		respond_to do |format|
      format.html # new.html.erb
    end
	end

	def create
		@outlet = @account_brand.outlets.new(params[:outlet])
    respond_to do |format|
      if @outlet.save
        format.html { redirect_to merchant_account_brand_outlets_path,:notice=>"Outlet Succesfully added"}
      else
        format.html { render action: "new" }
      end
    end
	end

	def edit
		@outlet = @account_brand.outlets.find(params[:id])
		@brands = Brand.all
	end

	def update
		@outlet = @account_brand.outlets.find(params[:id])
    respond_to do |format|
      if @account.update_attributes(params[:outlet])
        format.html { redirect_to merchant_account_brand_outlets_path }
      else
        format.html { render action: "edit" }
      end
    end
	end

	def destroy
    @outlet = @account_brand.outlets.find(params[:id])
    @outlet.destroy
    respond_to do |format|
      format.html { redirect_to merchant_account_brand_outlets_path }
    end
	end

	protected
	def load_account_brand
		@account_brand = @cuurent_account.account_brands.find(params[:account_brand_id])
	end
end