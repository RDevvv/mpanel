class Account < ActiveRecord::Base
  resourcify
  attr_accessible :account_balance, :registered_company_name, :account_key, :address,:owner_id, :area_id, :currency_id, :is_active, :is_deleted, :is_verified, :payment_status, :users_attributes, :areas_attributes
  has_many :account_brands, :dependent => :destroy
  has_many :brands, :through => :account_brands
  has_many :user_accounts, :dependent => :destroy
  has_many :users, :through => :user_accounts
  belongs_to :area
  validates_presence_of :registered_company_name, :address
  accepts_nested_attributes_for :users, :area
  after_create :add_owner
  
  def add_owner
    self.users.first.add_role :owner,self
  end

  def owner
    self.users.select{|u| u.has_role?(:owner,self) }.first
  end

  def name
    registered_company_name
  end
end
