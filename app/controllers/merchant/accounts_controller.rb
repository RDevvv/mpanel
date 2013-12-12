class Merchant::AccountsController <  Merchant::BaseController
# Only viewable Gullak Admin
  before_filter :load_current_account

  def index
    @accounts = current_user.accounts
  end

  def create
    @areas = Area.all
    @cities = City.all
    @countries = Country.all
    @account = Account.new(params[:account])
    respond_to do |format|
      if @account.save
        format.html { redirect_to verified_account_merchant_account_path(@account),:notice=>"Account is created!.Check your inbox to verify it" }
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
  	@account = Account.find(params[:id])
    @areas = Area.all
    @cities = City.all
    @countries = Country.all
    @accounts = Account.all
  end

  def new
    @account = Account.new
    @account.users.build
    @areas = Area.all
    @cities = City.all
    @countries = Country.all
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def destroy
   	@account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to edit_merchant_account_path(@account) }
    end
  end

  def update
   	@account = Account.find(params[:id])
    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to merchant_account_path }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def show
    # @accounts = current_user.accounts
    # @account = current_user.accounts.find(params[:id])
    # @current_account = @account
    # @user = @account.owner
    @account_brands = @current_account.account_brands
    @brands=Brand.all
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def verified_account
    @account = Account.find(params[:id])
    @user = @account.owner
  end
  
  def add_brands
    @current_account.brand_ids = @current_account.brand_ids.push(params[:brand_ids].collect(&:to_i)).flatten.compact.uniq
    if @current_account.save
      redirect_to merchant_accounts_path
    else
      @brands = Brand.by_brand_name(params[:search_name]).where("brands.id not in (?)", @current_account.brands.pluck(:id))
      @account_brands = @current_account.brands.order("brands.category_id asc")
      redirect_to merchant_account_path(@current_account)
    end
  end

  # def destroy_brand
  #   @account_brand = @current_account.account_brands.find(params[:id])
  #   @account_brand.destroy
  #   respond_to do |format|
  #     format.html { redirect_to merchant_account_account_brands_path(@current_account) }
  #   end
  # end

  protected
  def load_current_account
    if current_user
      @current_account = current_user.accounts.find(params[:id]) if params[:id].present?
      @current_account = @current_account || current_user.accounts.first
    end   
  end
  
end
