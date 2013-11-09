class Brand < ActiveRecord::Base
  attr_accessible :brand_alias, :brand_code, :brand_id, :brand_name, :category_id, :is_active, :is_verified, :website_url, :account_ids
  has_many :account_brands, :dependent => :destroy
  has_many :accounts, :through => :account_brands
end
