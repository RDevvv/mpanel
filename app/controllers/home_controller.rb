class HomeController < ApplicationController
  def index
  end

	def outlet_listing
	@brands = Account.first.brands
	end

	def map_listing
	end
end
