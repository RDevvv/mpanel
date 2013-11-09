class UserBrandAccount < ActiveRecord::Base
  attr_accessible :account_brand_id, :user_account_id
  belongs_to :user_account
  belongs_to :account_brand
end
