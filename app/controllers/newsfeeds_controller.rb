class NewsfeedsController < InheritedResources::Base

  def index
    @newsfeeds = Newsfeed.order.all.reverse

    respond_with @newsfeeds
  end

end
