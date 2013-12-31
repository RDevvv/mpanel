class BrandSession < ActiveRecord::Base
  belongs_to :brand
  belongs_to :customer_session

  attr_accessible :brand_id, :customer_session_id
end
