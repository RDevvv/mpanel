class AccountBrand < ActiveRecord::Base
  attr_accessible :account_id, :brand_id
  has_many :user_brand_accounts, :dependent => :destroy
  has_many :user_accounts, :through => :user_brand_accounts
  has_many :users, :through => :user_accounts
  has_many :outlets, :dependent => :destroy
  has_many :ads, :dependent => :destroy
  belongs_to :account
  belongs_to :brand

  def name
    self.brand.brand_name
  end
end
