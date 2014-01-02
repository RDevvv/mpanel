class Merchant::AdGroupsController <  Merchant::BaseController
  before_filter :load_account, :load_account_brand, :load_ad

  def show
    @ad_group  =@ad.ad_groups.find(params[:id])
    @ad_promocodes = @ad_group.ad_promocodes
    @outlets = @ad_group.outlets.uniq
  end

  def toggle_active
    @ad_group = @ad.ad_groups.find(params[:id])
    @ad_group.toggle_active

    redirect_to  merchant_account_account_brand_ad_path(@current_account,@account_brand,@ad)
  end

  def delete_outlet
    @ad_group = @ad.ad_groups.find(params[:id])
    @ad_group.delete_outlet(params[:outlet_id])
    redirect_to  merchant_account_account_brand_ad_ad_group_path(@current_account,@account_brand,@ad,@ad_group)
  end

  def more_promocodes
    @ad_group = @ad.ad_groups.find(params[:id])
  end

  def more_outlets
    @ad_group = @ad.ad_groups.find(params[:id])
    @outlets = @ad.account_brand.outlets - @ad_group.outlets
  end

  def add_more_promocodes
    @ad_group = @ad.ad_groups.find(params[:id])
    if @ad_group.is_multiple

      Array(params[:promocodes].split(",")).each do |promocode|
        if promocode.present?
          params[:ad_promocode] = {}
          params[:ad_promocode][:outlet_ids] =@ad_group.outlet_ids.uniq
          params[:ad_promocode][:promocode] = promocode
          params[:ad_promocode][:cap] = 1
          params[:ad_promocode][:set_name] = @ad_group.name
          ad_promocode = @ad.ad_promocodes.new(params[:ad_promocode])
          ad_promocode.ad_group = @ad_group
          ad_promocode.save
        end  
      end
    end
    redirect_to  merchant_account_account_brand_ad_ad_group_path(@current_account,@account_brand,@ad,@ad_group) 
  end


  def add_more_outlets
    @ad_group = @ad.ad_groups.find(params[:id])
    params[:outlet_ids] =params[:outlet_ids].reject {|x| x.blank?}
    @ad_group.add_more_outlets(params[:outlet_ids])

    redirect_to  merchant_account_account_brand_ad_ad_group_path(@current_account,@account_brand,@ad,@ad_group) 
  end

  def destroy
    @ad_group = @ad.ad_groups.find(params[:id])
    @ad_group.destroy
    redirect_to merchant_account_account_brand_ad_path(@current_account,@account_brand,@ad),:notice=>"Ad successfylly Destroyed"  
  end

  protected
  def load_account_brand
    @account_brand = @current_account.account_brands.find(params[:account_brand_id])
  end

  def load_ad
    @ad = @account_brand.ads.find(params[:ad_id])
  end
end