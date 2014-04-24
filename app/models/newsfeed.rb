class Newsfeed < ActiveRecord::Base
  attr_accessible :image_alt_text, :image_caption, :image_title, :journal_name, :journal_url, :news_excerpt, :news_title, :news_type, :news_url, :attachments_attributes

  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  accepts_nested_attributes_for :attachments ,allow_destroy: true

  after_create :create_campaign

  def create_campaign
    Campaign.create(:campaign_name => "#{self.id}"+ "-" +"#{self.news_type}"+" "+"#{self.created_at}"+" "+"#{self.news_title}", :source => "Social Media", :medium => "Wall", :placement =>  "User Feed", :marketer => "Shoffr", :campaign_type => "1TM Manual", :purpose => "Acquisition", :target => "Business")
  end

end
