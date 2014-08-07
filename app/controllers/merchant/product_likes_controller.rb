class Merchant::ProductLikesController < ApplicationController
    before_filter :load_customer_and_product, :only => [:create]
    respond_to :html, :json

    def create
        @product.product_likes.create(:customer_id => @customer.id)
        respond_with :root
    end

    def show
    end

    protected
    def load_customer_and_product
        @customer = Customer.where(:uuid => params[:customer_uuid]).first
        @product = Product.find(params[:product_id])
    end
end
