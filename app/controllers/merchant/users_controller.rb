class Merchant::UsersController <  Merchant::BaseController
  before_filter :load_account

  def new
    @user = @current_account.users.new 
    @users = User.all
    respond_to do |format|
      format.html # new.html.erb
    end 
  end

  def create
    @user = @current_account.users.new(params[:user])
    respond_to do |format|
      if @user.save
        UserAccount.create(:user_id=>@user.id,:account_id=>params[:account_id])
        format.html { redirect_to merchant_account_users_path,:notice=>"Account is created!.Check your inbox to verify it" }
      else
        format.html { render action: "new" }
      end
    end
  end

  def index 
    @users = @current_account.users.all
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def destroy
    @user = @current_account.users.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to merchant_account_users_path }
    end
  end

  def edit
    @user = @current_account.users.find(params[:id])
    @users = User.all
  end

  def update
    @user = @current_account.users.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to merchant_account_users_path, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def add_role
    @user = @current_account.users.find(params[:id])
    @user.add_role
    redirect_to merchant_account_users_path
  end
  
end