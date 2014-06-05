class Article < ActiveRecord::Base
  attr_accessible :body, :title, :attachments_attributes, :blog_category, :page_title, :blog_title, :blog_url, :blog_keywords,:summary_image, :image_caption, :summary_image_caption, :image_alt_text, :image_title, :blog_excerpt, :blog_body, :author, :author_linkedin_url, :social_share_caption, :twitter_blockquote

  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  accepts_nested_attributes_for :attachments ,allow_destroy: true
  has_many :article_comments, :as => :commentable

  validates_presence_of :page_title
  validates_presence_of :blog_title
  validates_presence_of :blog_category
  validates_presence_of :blog_url
  validates_presence_of :blog_keywords
  validates_presence_of :blog_excerpt
  validates_presence_of :author
  validates_presence_of :blog_body
  validates_presence_of :social_share_caption

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

  before_save :escape_blog_body
  after_create :create_campaign
  before_save :update_blog_url
  before_update :unescape_blog_body

  def escape_blog_body
    self.blog_body = CGI.escapeHTML self.blog_body
    self.twitter_blockquote = CGI.escapeHTML self.twitter_blockquote
  end

  def create_campaign
    campaign_name ="#{self.id}"+ "-" +"#{self.blog_category}"+" "+"#{self.created_at}"+" "+"#{self.blog_title}"
    Campaign.create(:campaign_name => campaign_name, :source => "Blog", :medium => "Native Client", :placement =>  "User Feed", :marketer => "Business", :campaign_type => "1T1 Button Click", :purpose => "Acquisition", :target => "Business")
    Campaign.create(:campaign_name => campaign_name, :source => "Social Media", :medium => "Wall", :placement =>  "User Feed", :marketer => "Shoffr", :campaign_type => "1TM Manual", :purpose => "Acquisition", :target => "Business")
  end

  def update_blog_url
    self.blog_url = self.blog_url.squish.gsub(' ','-')
  end

  def unescape_blog_body
    self.blog_body = CGI.unescapeHTML self.blog_body
    self.twitter_blockquote = CGI.unescapeHTML self.twitter_blockquote
  end
end
