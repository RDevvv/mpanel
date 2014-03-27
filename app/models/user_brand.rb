class UserBrand < ActiveRecord::Base
  attr_accessible :brand_id, :user_id
  belongs_to :user
  belongs_to :brand
end
