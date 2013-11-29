class Merchant::AdsController <  Merchant::BaseController
	before_filter :load_account, :load_account_brand

	def index
		@ads = @account_brand.ads		
	end

	protected
	def load_account_brand
		@account_brand = @current_account.account_brands.find(params[:account_brand_id])
	end
end