class Merchant::AccountBrandsController <  Merchant::BaseController
  before_filter :load_account

  def index 
    @brands = Brand.by_brand_name(params[:search_name]).where("brands.id not in (?)", @current_account.brands.pluck(:id))
  	@account_brands = @current_account.account_brands.includes(:brand).order("brands.category_id asc")
  	@accounts = @account_brands.first
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def add_brands
    @current_account.brand_ids = @current_account.brand_ids.push(params[:brand_ids].collect(&:to_i)).flatten.compact.uniq
    if @current_account.save
      redirect_to merchant_account_account_brands_path(@current_account)
    else
      @brands = Brand.by_brand_name(params[:search_name]).where("brands.id not in (?)", @current_account.brands.pluck(:id))
      @account_brands = @current_account.brands.order("brands.category_id asc")
    
      render :action=>:index
    end
  end

  def destroy
    @account_brand = @current_account.account_brands.find(params[:id])
    @account_brand.destroy
    respond_to do |format|
      format.html { redirect_to merchant_account_account_brands_path(@current_account) }
    end
  end

  def show
    @account_brand = @current_account.account_brands.find(params[:id])
    @outlets = @account_brand.outlets
  end
  
end