class Newsfeed < ActiveRecord::Base
  attr_accessible :image_alt_text, :image_caption, :image_title, :journal_name, :journal_url, :news_excerpt, :news_title, :news_type, :news_url
end
