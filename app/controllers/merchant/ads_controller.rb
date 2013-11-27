class Merchant::AdtsController <  Merchant::BaseController
	before_filter :load_account, :load_account_brand

	def index
		@ads = @account_brand.ads		
	end

	protected
	def load_account_brand
		@account_brand = @cuurent_account.account_brands.find(params[:account_brand_id])
	end
end