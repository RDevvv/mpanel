class NewsfeedsController < InheritedResources::Base
  layout 'newsfeeds'

  def index
    @newsfeeds = Newsfeed.order.all.reverse

    respond_with @newsfeeds
  end

end
