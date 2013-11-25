class Merchant::MerchantsController < Merchant::BaseController
  layout 'merchant'
  before_filter :load_account
  def index
 add_breadcrumb "Home 1", :merchant_merchants_path,:title=>"Home path"

  end
end
