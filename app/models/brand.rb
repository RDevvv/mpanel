class Brand < ActiveRecord::Base
  attr_accessible :brand_id, :brand_name, :category_id, :is_active, :is_verified, :website_url,:attachments_attributes
  has_many :account_brands, :dependent => :destroy
  has_many :accounts, :through => :account_brands
  belongs_to :category
  scope :by_brand_name ,lambda{|name|where("lower(brands.brand_name) like (?)","%#{name}%") if name.present?}
  has_many :attachments, :as => :attachable ,:class_name=>'Attachment'
  accepts_nested_attributes_for :attachments ,allow_destroy: true
end
