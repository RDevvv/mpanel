class Merchant::BrandsController <  Merchant::BaseController
before_filter :load_account

	def new
		@brand = @current_account.brands.new
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
    @brand = @account.brands.find(params[:id])
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to merchant_account_brands_path }
    end
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

  def index
    @brands = @current_account.brands.all
    @accounts = Account.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end
 
end