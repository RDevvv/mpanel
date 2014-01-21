class Merchant::BrandsController <  Merchant::BaseController
before_filter :load_account

	def new
		@brand = @current_account.brands.new
    @categories = Category.order("category_name")
		respond_to do |format|
      format.html # new.html.erb
    end
	end

	def create
		@brand = @current_account.brands.new(params[:brand])
    respond_to do |format|
      if @brand.save
        format.html { redirect_to merchant_account_account_brands_path(@current_account),:notice=>"Brand Succesfully added"}
      else
        @categories = Category.all
        format.html { render action: "new" }
      end
    end
	end

	def destroy
    @brand = @current_account.brands.find(params[:id])
    @brand.destroy
    respond_to do |format|
      format.html { redirect_to merchant_account_brands_path }
    end
	end

	def show
		@brand = @current_account.brands.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
    end
	end

	def edit
    @brand = @current_account.brands.find(params[:id])
    @categories = Category.all
	end

	def update
    @brand = @current_account.brands.find(params[:id])

    respond_to do |format|
      if @brand.update_attributes(params[:brand])
        format.html { redirect_to merchant_account_brands_path, notice: 'Brand was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
	end

  def index
    @brands = @current_account.brands.all
    @accounts = Account.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end
 
end