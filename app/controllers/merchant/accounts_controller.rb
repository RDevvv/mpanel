class Merchant::AccountsController <  Merchant::BaseController
# Only viewable Gullak Admin
  def index
    
  end
  def create
  	@account = Account.new(params[:account])
    respond_to do |format|
      if @account.save
        format.html { redirect_to merchant_verified_account_account_path(@account),:notice=>"Account is created!.Check your inbox to verify it" }
      else
        format.html { render action: "new" }
      end
    end
  end

  def edit
  	@account = Account.find(params[:id])
  end

  def new
    @account = Account.new
    @account.users.build
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def destroy
  	@account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  def update
  	@account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to root_path }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def show 
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
