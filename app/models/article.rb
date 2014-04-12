class Article < ActiveRecord::Base
  attr_accessible :body, :title, :attachments_attributes, :blog_category, :page_title, :blog_title, :blog_url, :blog_keywords,:summary_image, :image_caption, :summary_image_caption, :image_alt_text, :image_title, :blog_excerpt, :blog_body, :author, :author_linkedin_url, :social_share_caption, :twitter_blockquote

  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  accepts_nested_attributes_for :attachments ,allow_destroy: true
  has_many :comments, :as => :commentable

  validates_presence_of :page_title
  validates_presence_of :blog_title
  validates_presence_of :blog_category
  validates_presence_of :blog_url
  validates_presence_of :blog_keywords
  validates_presence_of :blog_excerpt
  validates_presence_of :author
  validates_presence_of :author_linkedin_url
  validates_presence_of :social_share_caption
  validates_presence_of :twitter_blockquote
  validates_presence_of :blog_body
  validates_presence_of :image_title
  validates_presence_of :image_alt_text
  validates_presence_of :image_caption
  validates_presence_of :summary_image_caption

  validates_length_of :blog_title, :maximum => 65, :allow_blank => false
  validates_length_of :blog_url, :maximum => 50, :allow_blank => false
  validates_length_of :image_caption, :maximum => 160, :allow_blank => false
  validates_length_of :summary_image_caption, :maximum => 80, :allow_blank => false
  validates_length_of :image_alt_text, :maximum => 50, :allow_blank => false
  validates_length_of :image_title, :maximum => 20, :allow_blank => false
  validates_length_of :blog_excerpt, :maximum => 150, :allow_blank => false
  validates_length_of :social_share_caption, :maximum => 115, :allow_blank => false
end
