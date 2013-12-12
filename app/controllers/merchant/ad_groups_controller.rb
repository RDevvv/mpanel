class Merchant::AdGroupsController <  Merchant::BaseController
  before_filter :load_account, :load_account_brand, :load_ad

  def show
    @ad_group  =@ad.ad_groups.find(params[:id])
    @ad_promocodes = @ad_group.ad_promocodes
    @outlets = @ad_group.outlets
  end

  def activate_promocodes
    @ad = @account_brand.ads.find(params[:id])
    @ad_groups = @ad.ad_groups
    @ad_groups.each do |ad_group|
      if ad_promocodes = ad_group.ad_promocodes.present?
        ad_promocodes = ad_group.ad_promocodes
        ad_promocodes.each do |ad_promocode|
          if ad_promocode.present?
            if !params[:is_active].nil?
              ad_group.update_attributes(is_active: true)
              ad_promocode.update_attributes(is_active: true)
            else
              ad_group.update_attributes(is_active: false)
              ad_promocode.update_attributes(is_active: false)
            end
          end 
        end
      end
    end
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