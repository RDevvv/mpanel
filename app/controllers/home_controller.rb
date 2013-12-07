class HomeController < ApplicationController
  def index
  end

	def outlet_listing
	@brands = Brand.all
	end

	def map_listing
        @brands = Brand.all
	end
end
