class NativeNotification < ActiveRecord::Base
  belongs_to :ad
  belongs_to :customer

  attr_accessible :ad_id, :customer_id

  validates :ad_id, presence: true
  validates :customer_id, presence: true
end
