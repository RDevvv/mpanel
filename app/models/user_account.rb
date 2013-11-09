class UserAccount < ActiveRecord::Base
  attr_accessible :account_id, :user_id, :account_brand_ids
  has_many :user_brand_accounts, :dependent => :destroy
  has_many :account_brands, :through => :user_brand_accounts
  belongs_to :account
  belongs_to :user
end
