class CustomerKeyword < ActiveRecord::Base
  belongs_to :customer
  belongs_to :keyword

  attr_accessible :customer_id, :keyword_id
  validates :customer_id, :uniqueness => {:scope => :keyword_id}
end
