class CustomerBrandScore < ActiveRecord::Base
  attr_accessible :brand_id, :brand_like, :call, :category_like, :customer_id, :score, :share, :unlock, :view, :poster_share, :is_prestine

  belongs_to :brand
  belongs_to :customer
end
