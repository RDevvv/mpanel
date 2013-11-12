class AccountBrand < ActiveRecord::Base
  attr_accessible :account_id, :brand_id, :is_active, :user_account_ids, :daily_cap
  has_many :user_brand_accounts, :dependent => :destroy
  has_many :user_accounts, :through => :user_brand_accounts
  has_many :users, :through => :user_accounts
  has_many :outlet, :dependent => :destroy
  has_many :ad, :dependent => :destroy
  belongs_to :account
  belongs_to :brand
end
