class CustomerBrandScore < ActiveRecord::Base
  attr_accessible :brand_id, :brand_like, :call_count, :category_like, :customer_id, :score, :share_count, :unlock_count, :view_count

  belongs_to :brand
  belongs_to :customer
end
