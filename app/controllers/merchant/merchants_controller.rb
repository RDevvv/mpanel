class Merchant::MerchantsController < Merchant::BaseController
  layout 'merchant'
  before_filter :load_account
  def index

  end
end
