class HomeController < ApplicationController
  def index
  end

	def outlet_listing
	@Result = Account.first.account_brand.outlet.all 
	end

	def map_listing
	end
end
