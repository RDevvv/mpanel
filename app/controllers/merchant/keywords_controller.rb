class Merchant::KeywordsController < Merchant::BaseController
	before_filter :load_account, :load_account_and_brand, :load_ad

	def new
		@keyword = @ad.keywords.new
	end

	def create
		@keyword = @ad.keywords.new(params[:keyword])
		if @keyword.save
			@ad_keyword = @ad.ad_keywords.new(:ad_id=>params[:ad_id], :keyword_id=>@keyword.id)
			@ad_keyword.save
      redirect_to merchant_account_account_brand_ad_path(@current_account,@account_brand,@ad),:notice=>"Keyword successfylly created"
    else
      render :action=>"new"
    end
	end

	def edit
		@keyword = @ad.keywords.find(params[:id])
	end

	def update
		@keyword = @ad.keywords.find(params[:id])
    if @keyword.update_attributes(params[:keyword])
      redirect_to edit_merchant_account_account_brand_ad_keyword_path(@current_account,@account_brand,@ad,@keyword) ,:notice=>"Keyword successfylly updated"
    else
      render :action=>"edit"
    end
	end

	protected
	def load_account_and_brand
		@account_brand = @current_account.account_brands.find(params[:account_brand_id])
	end

	def load_ad
		@ad = @account_brand.ads.find(params[:ad_id])
	end

end
