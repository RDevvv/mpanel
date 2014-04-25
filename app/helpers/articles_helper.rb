module ArticlesHelper

  def generate_article_title
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr - Blog"
      else
        return @article.page_title
      end
    end
  end

  def title
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr Blog -  Indian retail & customers insights"
      else
        return @article.page_title
      end
    end
  end

  def description
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr blog reports on insights and analysis from the Indian retail industry, customer behaviour, mobile marketing, and Shoffr product updates."
      else
        return @article.blog_excerpt
      end
    end
  end

  def keywords
    if controller_name == 'articles'
      if action_name == 'index'
        return "retail industry blog, customer insights blog, digital marketing blog, mobile marketing blog, location based marketing blog, retail industry insights, customer insights, digital marketing, digital marketing insights, behavioural marketing, contextual marketing, increase footfall, mobile marketing, mobile advertising, location based marketing, location based advertising"
      else
        return @article.blog_keywords
      end
    end
  end

  def og_title
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr Blog -  Indian retail & customers insights"
      else
        return @article.blog_title
      end
    end
  end

  def og_url
    if controller_name == 'articles'
      if action_name == 'index'
        return ""
      else
        return @article.blog_url.gsub(' ','-')
      end
    end
  end

  def og_description
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr blog reports on insights and analysis from the Indian retail industry, customer behaviour, mobile marketing, and Shoffr product updates."
      else
        return @article.blog_excerpt
      end
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
    end
  end

  def twitter_card
    if controller_name == 'articles'
      if action_name == 'index'
        return "summary"
      else
        return "summary_large_image"
      end
    end
  end

  def twitter_title
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr Blog -  Indian retail & customers insights"
      else
        return @article.blog_title
      end
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
    end
  end

  def twitter_description
    if controller_name == 'articles'
      if action_name == 'index'
        return "Shoffr blog reports on insights and analysis from the Indian retail industry, customer behaviour, mobile marketing, and Shoffr product updates."
      else
        return @article.blog_excerpt
      end
    end
  end

end