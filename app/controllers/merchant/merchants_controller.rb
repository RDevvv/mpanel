class Merchant::MerchantsController < Merchant::BaseController
  
  before_filter :load_account
  
  def index
	  if current_user.has_role?(:admin)
      redirect_to merchant_accounts_path
    elsif current_user.has_role?(:outlet_manager)
      redirect_to merchant_select_outlet_path
	  else
	    redirect_to new_merchant_user_session_path
	  end
  end
  
end
