class Account < ActiveRecord::Base
  attr_accessible :account_balance, :account_key, :address_line1, :address_line2, :admin_user_id, :area_id, :city_id, :currency_id, :is_active, :is_deleted, :payment_status, :pincode, :user_ids, :brand_ids
  has_many :account_brands, :dependent => :destroy
  has_many :brands, :through => :account_brands
  has_many :user_accounts, :dependent => :destroy
  has_many :users, :through => :user_accounts
end
