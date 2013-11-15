class Merchant::BaseController < ApplicationController
  layout 'merchant'
  helper_method :current_user
  add_breadcrumb "Home", :merchant_merchants_path,:title=>"Home path"
  
  def current_user
    current_merchant_user
  end

  protected
  def load_account
    if current_user
      @account = current_user.accounts.find(params[:account_id]) if params[:account_id]
      @account = @account || current_user.accounts.first
    end  
  end
end