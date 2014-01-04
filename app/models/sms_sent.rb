class SmsSent < ActiveRecord::Base
  belongs_to :customer
  belongs_to :ad_promocode_outlet

  attr_accessible :text, :is_sent

  validates :text, :presence => true
  validates :customer_id, :presence => true
end
