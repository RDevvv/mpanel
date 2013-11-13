class AccountsController < ApplicationController
  def create
  	@account = Account.new(params[:account])
    binding.pry
    respond_to do |format|
      if @account.save
        format.html { redirect_to new_account_path }
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
    # @users = @account.users.first
    1.times { @account.users.build }
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

end
