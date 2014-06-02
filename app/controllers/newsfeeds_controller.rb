class NewsfeedsController < InheritedResources::Base
  layout 'blog'

  def index
    @newsfeeds = Newsfeed.order.all.reverse

    respond_with @newsfeeds
  end

end
