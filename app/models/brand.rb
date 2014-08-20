class Brand < ActiveRecord::Base
  has_one :customer_brand_score
  has_many :account_brands, :dependent => :destroy
  has_many :accounts, :through => :account_brands
  has_many :user_brands, :dependent => :destroy
  has_many :users, :through => :user_brands
  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  belongs_to :category

  attr_accessible :brand_id, :brand_name, :category_id, :is_active, :is_verified, :website_url,:attachments_attributes
  attr_accessible :twitter_followers_count, :twitter_handle, :facebook_handle, :facebook_likes_count, :facebook_username, :facebook_id
  accepts_nested_attributes_for :attachments ,allow_destroy: true

  validates :brand_name, :uniqueness => true, :presence => true

  scope :by_brand_name ,lambda{|name|where("lower(brands.brand_name) like (?)","%#{name}%") if name.present?}

  def name
    self.brand_name
  end

end
