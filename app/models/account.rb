class Account < ActiveRecord::Base
  attr_accessible :account_balance, :registered_company_name, :account_key, :address,:owner_id, :area_id, :currency_id, :is_active, :is_deleted, :is_verified, :payment_status, :users_attributes
  has_many :account_brands, :dependent => :destroy
  has_many :brands, :through => :account_brands
  has_many :user_accounts, :dependent => :destroy
  has_many :users, :through => :user_accounts
  accepts_nested_attributes_for :users
  belongs_to :owner,:class_name=>"User",:foreign_key=>:owner_id
  belongs_to :area
end