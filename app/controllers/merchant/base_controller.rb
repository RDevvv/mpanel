class Merchant::BaseController < ApplicationController
  layout 'merchant'
  helper_method :current_user
   add_breadcrumb "Home", :merchant_merchants_path,:title=>"Home path"
  def current_user
    current_merchant_user
  end
end