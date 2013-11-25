class Merchant::AccountsController <  Merchant::BaseController
# Only viewable Gullak Admin
before_filter :load_account,:only=>[:index]
  def index
    @accounts = current_user.accounts
  end
  def create
    binding.pry
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
    @account.build_area
    #@account.areas.build
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
    @accounts = Account.all
    @account = Account.find(params[:id])
    @user = @account.owner
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def verified_account
    @account = Account.find(params[:id])
    @user = @account.owner
  end
  
end
