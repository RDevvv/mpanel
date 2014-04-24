class NewsfeedsController < InheritedResources::Base

  def index
    @newsfeeds = Newsfeed.all

    respond_with @newsfeeds
  end

end
