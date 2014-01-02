class Merchant::BaseController < ApplicationController
  layout 'merchant'
  helper_method :current_user
  add_breadcrumb "Home", :merchant_merchants_path,:title=>"Home path"
  before_filter :authenticate_merchant_user!
  def current_user
    current_merchant_user
  end

  protected
  def load_account
    
    if current_user
      if params[:account_id]
        @current_account = current_user.accounts.find(params[:account_id]) 
      else
        @current_account = current_user.accounts.first
      end
    end  
  end

   def user_for_paper_trail
    if current_user
      current_user
    else
      'Unknown User'  
    end  
  end

end