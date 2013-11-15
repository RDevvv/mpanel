class Merchant::BrandsController <  Merchant::BaseController
before_filter :load_account

	def new
		@brand = @account.brands.new
		respond_to do |format|
      format.html # new.html.erb
    end
	end

	def create
		@brand = @account.brands.new(params[:barnd])

    respond_to do |format|
      if @brand.save
        format.html { redirect_to root_path }
      else
        format.html { render action: "new" }
      end
    end
	end

	def destroy
	end

	def show
	end

	def edit
	end

	def update
	end

	protected
  def load_account
  	binding.pry
   @account = Account.find(params[:id]) 
  end
end