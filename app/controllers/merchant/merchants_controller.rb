class Merchant::MerchantsController < Merchant::BaseController
  
  before_filter :load_account
  
  def index
	  if current_user
      redirect_to merchant_accounts_path
	  else
	    redirect_to new_merchant_user_session_path
	  end
  end
  
end
