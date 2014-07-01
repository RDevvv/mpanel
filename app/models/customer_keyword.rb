class CustomerKeyword < ActiveRecord::Base
  belongs_to :customer
  belongs_to :keyword

  attr_accessible :customer_id, :keyword_id
end
