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
		# @outlets = @account_brand.outlets.pluck(:outlet_name)
		respond_to do |format|
      format.html # new.html.erb
    end
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

	def edit
		@outlet = @account_brand.outlets.find(params[:id])	
	end

	def update
		@outlet = @account_brand.outlets.find(params[:id])
    respond_to do |format|
      if @outlet.update_attributes(params[:outlet])
        format.html { redirect_to merchant_account_account_brand_outlets_path(@current_account,@account_brand),:notice=>"Outlet Succesfully Updated #{undo_link}" }
      else
        format.html { render action: "edit" }
      end
    end
	end

	def destroy
    @outlet = @account_brand.outlets.find(params[:id])
    @outlet.destroy
    respond_to do |format|
    	format.html { redirect_to merchant_account_account_brand_outlets_path(@current_account,@account_brand),:notice=>"Outlet Succesfully Destoyed #{undo_link}"}
    end
	end

	protected
	def load_account_and_brand
		@account_brand = @current_account.account_brands.find(params[:account_brand_id])
	end

	private
	def undo_link
  	view_context.link_to("undo", revert_version_path(@outlet.versions.scoped.last), :method => :post)
	end
end