class Newsfeed < ActiveRecord::Base
  attr_accessible :image_alt_text, :image_caption, :image_title, :journal_name, :journal_url, :news_excerpt, :news_title, :news_type, :news_url, :attachments_attributes

  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  accepts_nested_attributes_for :attachments ,allow_destroy: true

  validates_presence_of :image_alt_text
  validates_presence_of :image_caption
  validates_presence_of :image_title
  validates_presence_of :journal_name
  validates_presence_of :journal_url
  validates_presence_of :news_excerpt
  validates_presence_of :news_title
  validates_presence_of :news_type
  validates_presence_of :news_url

  after_create :create_campaign

  def create_campaign
      campaign_name = self.id+'-'+self.news_type+' '+self.created_at+' '+self.news_title
      Campaign.create(:campaign_name => campaign_name, :source => "Social Media", :medium => "Wall", :placement =>  "User Feed", :marketer => "Shoffr", :campaign_type => "1TM Manual", :purpose => "Acquisition", :target => "Business")
  end

end
