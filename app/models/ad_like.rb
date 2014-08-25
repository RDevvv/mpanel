class AdLike < ActiveRecord::Base
  belongs_to :customer
  belongs_to :ad
  belongs_to :outlet
  attr_accessible :is_unlocked, :customer_id, :ad_id, :outlet_id

  validates :customer_id, :uniqueness => {:scope => :ad_id}
end
