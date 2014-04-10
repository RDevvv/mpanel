class Article < ActiveRecord::Base
  attr_accessible :body, :title, :attachments_attributes, :blog_category, :page_title, :blog_title, :blog_url, :blog_keywords,:summary_image, :image_caption, :summary_image_caption, :image_alt_text, :image_title, :blog_excerpt, :blog_body, :author, :author_linkedin_url, :social_share_caption

  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  accepts_nested_attributes_for :attachments ,allow_destroy: true
  has_many :comments, :as => :commentable
end
