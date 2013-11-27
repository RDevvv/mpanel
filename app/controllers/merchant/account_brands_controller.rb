class Merchant::AccountBrandsController <  Merchant::BaseController
  before_filter :load_account

  def index 
    @brands = Brand.by_brand_name(params[:search_name]).where("brands.id not in (?)", @current_account.brands.pluck(:id))
  	@account_brands = @current_account.brands.order("brands.category_id asc")
    
  	# @accounts = @current_account.account_brands
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
end