class Merchant::KeywordsController < Merchant::BaseController
    before_filter :load_account, :load_account_and_brand
    skip_before_filter :load_account_and_brand, :authenticate_merchant_user!, :only => [:get_keywords, :get_customer_keywords]

    def new
        @keyword = Keyword.new
    end

    def create
        @keyword = Keyword.new(params[:keyword])
        if @keyword.save
            redirect_to merchant_account_account_brand_ads_path(@current_account,@account_brand),:notice=>"Keyword successfylly created"
        else
            render :action=>"new"
        end
    end

    def get_keywords
        @keyword =Keyword.where("keyword ilike '%#{params[:query]}%'").map{|k|k.keyword}
        render :json => @keyword
    end

    def get_customer_keywords
        @customer = Customer.where(:uuid => params[:customer_uuid]).first
        @keywords = @customer.keywords.map{|k|k.keyword}
        render :json => @keywords
    end

    # def edit
    # 	@keyword = Keyword.find(params[:id])
    # end

    # def update
    # 	@keyword = Keyword.find(params[:id])
    #    if @keyword.update_attributes(params[:keyword])
    #      redirect_to merchant_account_account_brand_path(@current_account,@account_brand) ,:notice=>"Keyword successfylly updated"
    #    else
    #      render :action=>"edit"
    #    end
    # end

    protected
    def load_account_and_brand
        @account_brand = @current_account.account_brands.find(params[:account_brand_id])
    end

end
