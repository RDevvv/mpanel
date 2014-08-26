class Merchant::ProductsController < Merchant::BaseController
    before_filter :load_account, :load_account_and_brand, :except => [:show, :get_products_by_outlet]
    skip_before_filter :authenticate_merchant_user!
    respond_to :html, :json

    def index
        @products = @brand.products
    end

    def new
        @product = Product.new
    end

    def edit
        @product = @brand.products.find(params[:id])
    end

    def show
        @product = Product.find(params[:id])
        @customer = Customer.where(:uuid => params[:customer_uuid]).first
        @product_liked = true unless @product.product_likes.where(:customer_id => @customer.id).blank?
    end

    def create
        @product = @brand.products.create(params[:product])
        respond_with :merchant, @current_account, @brand, @product, :location => merchant_account_brand_products_path
    end

    def update
        @product = @brand.products.find(params[:id])
        @product.update_attributes(params[:product])
        respond_with :merchant, @current_account, @brand, @product, :location => merchant_account_brand_products_path
    end

    def destroy
        @product = @brand.products.find(params[:id])
        @product.destroy
        respond_with :merchant, @current_account, @brand, @product, :location => merchant_account_brand_products_path
    end

    def get_products_by_outlet
        @products = Outlet.find(params[:outlet_id]).account_brand.products
        respond_with @products
    end

    protected
    def load_account_and_brand
        @brand = @current_account.brands.find(params[:brand_id])
    end
end
