class AccountBrand < ActiveRecord::Base
  attr_accessible :account_id, :brand_id, :deleted_at
  has_many :outlets, :dependent => :destroy
  has_many :ads, :dependent => :destroy
  has_many :products

  belongs_to :account
  belongs_to :brand
  has_paper_trail
  acts_as_paranoid
  def name
    self.brand.brand_name
  end
end
