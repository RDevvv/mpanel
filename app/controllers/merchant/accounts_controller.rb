class Merchant::AccountsController <  Merchant::BaseController
# Only viewable Gullak Admin
  load_and_authorize_resource
  
  before_filter :load_account,:only=>[:add_brands]
  skip_before_filter :authenticate_merchant_user!,:only=>[:new,:create,:verified_account]
  
  def index
    @accounts = current_user.accounts.uniq
  end

  def new
    @account = Account.new
    @account.users.build
    @cities = City.order("city_name")
    @areas = []
    @countries = Country.all
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    @cities = City.order("city_name")
    @areas = []
    @account = Account.new(params[:account])  
    @area = Area.by_area_name(params[:area_name]).by_pincode(params[:pincode]).first
    @area = Area.create!(:city_id=>params[:city_id], :area_name=>params[:area_name].downcase,:pincode=>params[:pincode]) if @area.blank?
    @account.area = @area
    @users = @account.users << current_merchant_user if current_merchant_user
    respond_to do |format|
      if @account.save
        Emailer.registration_confirmation(@users).deliver
        if current_merchant_user
          format.html { redirect_to merchant_accounts_path()}
        else
        end
        format.html { redirect_to verified_account_merchant_account_path(@account),:notice=>"Account is created!.Check your inbox to verify it" }
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
  	@account = current_user.accounts.find(params[:id])
    @cities = City.order("city_name")
    @areas = []
    @countries = Country.all
    @accounts = Account.all
  end

  def populate_areas
    @areas = Area.where(:city_id=>params[:city_id]).order(:area_name)
  end

  def destroy
   	@account = current_user.accounts.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to edit_merchant_account_path(@account) }
    end
  end

  def update

    @account = current_user.accounts.find(params[:id])
    @area = Area.by_area_name(params[:area_name]).by_pincode(params[:pincode]).first
    @area = Area.create!(:city_id=>params[:city_id], :area_name=>params[:area_name].downcase,:pincode=>params[:pincode]) if @area.blank?
    params[:account][:area_id] = @area.id
    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to merchant_account_path ,:notice=>"Account Succesfully Updated" }
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
    @current_account = current_user.accounts.find(params[:id])
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
      redirect_to merchant_account_path(@current_account)
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
  
end
