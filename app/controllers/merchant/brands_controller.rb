class Merchant::BrandsController <  Merchant::BaseController
before_filter :load_account

	def new
		@brand = @account.brands.new
		respond_to do |format|
      format.html # new.html.erb
    end
	end

	def create
		@brand = @account.brands.new(params[:brand])
    respond_to do |format|
      if @brand.save
        format.html { redirect_to root_path } #merchant_account_brand_path(@account,@brand)
      else
        format.html { render action: "new" }
      end
    end
	end

	def destroy
	end

	def show
		@brand = @account.brands.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
	end

	def edit
	end

	def update
	end

	protected
  def load_account
   @account = Account.find(params[:account_id]) 
  end
end