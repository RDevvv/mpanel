class Account < ActiveRecord::Base
  attr_accessible :account_balance, :registered_company_name, :account_key, :address,:admin_user_id, :area_id, :currency_id, :is_active, :is_deleted, :is_verified, :payment_status, :user_ids, :brand_ids
  has_many :account_brands, :dependent => :destroy
  has_many :brands, :through => :account_brands
  has_many :user_accounts, :dependent => :destroy
  has_many :users, :through => :user_accounts
  belongs_to :area
end
