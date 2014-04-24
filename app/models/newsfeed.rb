class Newsfeed < ActiveRecord::Base
  attr_accessible :image_alt_text, :image_caption, :image_title, :journal_name, :journal_url, :news_excerpt, :news_title, :news_type, :news_url, :attachments_attributes

  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  accepts_nested_attributes_for :attachments ,allow_destroy: true
end
