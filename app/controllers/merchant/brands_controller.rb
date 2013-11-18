class Merchant::BrandsController <  Merchant::BaseController
before_filter :load_account

	def new
		@brand = @account.brands.new
    @categories = Category.all
		respond_to do |format|
      format.html # new.html.erb
    end
	end

	def create
		@brand = @account.brands.new(params[:brand])
    respond_to do |format|
      if @brand.save
        format.html { redirect_to merchant_account_account_brands_path(@account),:notice=>"Brand Succesfully added"}
      else
        @categories = Category.all
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


end