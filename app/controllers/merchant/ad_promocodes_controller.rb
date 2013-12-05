class Merchant::AdPromocodesController <  Merchant::BaseController
	before_filter :load_ad

	def index
    @ad_promocodes = AdPromocode.all
  end

  def show
  end

  def new
    @ad_promocodes = AdPromocode.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected
  def load_ad
    @ad = Ad.all.find(params[:id])
  end

end