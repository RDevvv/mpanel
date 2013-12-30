class SmsSent < ActiveRecord::Base
  belongs_to :customer_id
  belongs_to :ad_promocode_id

  attr_accessible :text, :is_sent

  validates :text, :presence => true
  validates :customer_id, :presence => true
end
