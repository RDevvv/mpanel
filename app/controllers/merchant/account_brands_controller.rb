class Merchant::AccountBrandsController <  Merchant::BaseController
  before_filter :load_account

  def index 
    @brands = Brand.by_brand_name(params[:search_name]).where("brands.id not in (?)", @account.brands.pluck(:id))
  	@account_brands = @account.brands
  	respond_to do |format|
      format.html # index.html.erb
    end
  end
  
end