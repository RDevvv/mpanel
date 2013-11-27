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

  def add_brands
    @current_account.brand_ids = @current_account.brand_ids.push(params[:brand_ids].collect(&:to_i)).flatten.compact.uniq
    if @current_account.save
      redirect_to merchant_account_account_brands_path(@current_account)
    else
      render :action=>:index
    end
  end
  
end