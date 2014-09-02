class Merchant::FacebookPostsController < ApplicationController
  respond_to :json

  def index
    @facebook_posts = Brand.find(params[:brand_id]).facebook_posts
  end
end
