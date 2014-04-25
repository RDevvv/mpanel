module ArticlesHelper

  def generate_article_title
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr - Blog"
      else
        return @article.page_title
      end
    else
      return "Shoffr News"
    end
  end

  def title
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr Blog -  Indian retail & customers insights"
      else
        return @article.page_title
      end
    else
      return "Shoffr News"
    end
  end

  def description
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr blog reports on insights and analysis from the Indian retail industry, customer behaviour, mobile marketing, and Shoffr product updates."
      else
        return @article.blog_excerpt
      end
    else
      return "Shoffr News delivers curated news and analysis about Indian Retail. It also reports on media coverage about Shoffr."
    end
  end

  def keywords
    if controller_name == 'articles'
      if action_name == 'index'
        return "retail industry blog, customer insights blog, digital marketing blog, mobile marketing blog, location based marketing blog, retail industry insights, customer insights, digital marketing, digital marketing insights, behavioural marketing, contextual marketing, increase footfall, mobile marketing, mobile advertising, location based marketing, location based advertising"
      else
        return @article.blog_keywords
      end
    else
      return ""
    end
  end

  def og_title
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr Blog -  Indian retail & customers insights"
      else
        return @article.blog_title
      end
    else
      return "Shoffr News"
    end
  end

  def og_url
    if controller_name == 'articles'
      if action_name == 'index'
        return "articles"
      else
        return "articles/#{@article.blog_url.gsub(' ','-')}"
      end
    else
      return "newsfeeds"
    end
  end

  def og_description
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr blog reports on insights and analysis from the Indian retail industry, customer behaviour, mobile marketing, and Shoffr product updates."
      else
        return @article.blog_excerpt
      end
    else
      return "Shoffr News delivers curated news and analysis about Indian Retail. It also reports on media coverage about Shoffr."
    end
  end

  def og_image
    if controller_name == 'articles'
      if action_name == 'index'
        return "http://shoffr.com/assets/social-media/shoffr_social_media_logo.png"
      else
        if @article.attachments.present?
          return @article.attachments.order(:id).last.image
        end
      end
    else
      return "http://shoffr.com/assets/social-media/shoffr_social_media_logo.png"
    end
  end

  def twitter_card
    if controller_name == 'articles'
      if action_name == 'index'
        return "summary"
      else
        return "summary_large_image"
      end
    else
      return "summary"
    end
  end

  def twitter_title
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr Blog -  Indian retail & customers insights"
      else
        return @article.blog_title
      end
    else
      return "Shoffr News"
    end
  end

  def twitter_url
    if controller_name == 'articles'
      if action_name == 'index'
        return "articles"
      else
        return "articles/#{@article.blog_url.gsub(' ','-')}"
      end
    else
      return "newsfeeds"
    end
  end

  def twitter_image_src
    if controller_name == 'articles'
      if action_name == 'index'
        return "http://shoffr.com/assets/social-media/shoffr_social_media_logo.png"
      else
        if @article.attachments.present?
          return @article.attachments.order(:id).last.image
        end
      end
    else
      return "http://shoffr.com/assets/social-media/shoffr_social_media_logo.png"
    end
  end

  def twitter_description
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr blog reports on insights and analysis from the Indian retail industry, customer behaviour, mobile marketing, and Shoffr product updates."
      else
        return @article.blog_excerpt
      end
    else
      return "Shoffr News delivers curated news and analysis about Indian Retail. It also reports on media coverage about Shoffr."
    end
  end

end