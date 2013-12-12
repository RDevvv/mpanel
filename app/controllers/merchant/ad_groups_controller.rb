class Merchant::AdGroupsController <  Merchant::BaseController
  before_filter :load_account, :load_account_brand, :load_ad

  def show
    @ad_group  =@ad.ad_groups.find(params[:id])
    @ad_promocodes = @ad_group.ad_promocodes
    @outlets = @ad_group.outlets
  end

  def toggle_active
    @ad_group = @ad.ad_groups.find(params[:id])
    @ad_group.toggle_active

    redirect_to  merchant_account_account_brand_ad_path(@current_account,@account_brand,@ad)
  end

  protected
  def load_account_brand
    @account_brand = @current_account.account_brands.find(params[:account_brand_id])
  end

  def load_ad
    @ad = @account_brand.ads.find(params[:ad_id])
  end
end