class Merchant::UsersController <  Merchant::BaseController
  load_and_authorize_resource

  def index
    users = Array.new
    current_user.accounts.each do |account|
      users = users + account.users
    end
    @users = users.uniq
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
    @user = User.new
    @accounts = current_user.accounts
    respond_to do |format|
      format.html # new.html.erb
    end 
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to merchant_users_path,:notice=>"Account is created!.Check your inbox to verify it" }
      else
        format.html { render action: "new" }
      end
    end
  end

  def add_user
    @accounts = current_user.accounts
    @user = User.new(params[:user])
    @account = Account.find(params[:user][:id])
    respond_to do |format|
      if @user.save
        Emailer.registration_confirmation(@user,@account).deliver
        @user.add_account(@account)
        format.html { redirect_to merchant_users_path,:notice=>"Account is created!.Check your inbox to verify it" }
      else
        if User.find_by_email(@user.email).present?
          user = User.find_by_email(@user.email)
          UserAccount.create(:account_id=>@account.id, :user_id=>user.id)
          Emailer.user_confirmation(user,@account).deliver
          format.html { redirect_to merchant_users_path,:notice=>"Account is created!.Check your inbox to verify it" }
        else
          format.html { render action: "new" }
        end
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to merchant_users_path }
    end
  end

  def edit
    @user = User.find(params[:id])
    @users = User.all
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to merchant_users_path, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

end