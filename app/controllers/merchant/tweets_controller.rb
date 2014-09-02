class Merchant::TweetsController < ApplicationController
  respond_to :json

  def index
    @tweets = Brand.find(params[:brand_id]).tweets
  end
end
