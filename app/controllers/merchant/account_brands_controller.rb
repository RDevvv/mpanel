class Merchant::AccountBrandsController <  Merchant::BaseController
  before_filter :load_account

  def index
  	if params[:search]
  		@account_brands = @account.brands.by_brand_name(params[:search][:nm])
  		if @account.brands.by_brand_name(params[:search][:nm]).count == 0
      	@account_brands = @account.brands
      end
  	else
      @account_brands = @account.brands
  	end
  	respond_to do |format|
      format.html # index.html.erb
    end
  end

  protected
  def load_account
   @account = Account.find(params[:account_id]) 
  end
end