class NativeNotification < ActiveRecord::Base
  belongs_to :ad
  has_one :customer_location
  belongs_to :customer

  attr_accessible :ad_id, :customer_id

  validates :ad_id, presence: true
  validates :customer_id, presence: true

  def self.check_if_within_timeframe
      upper_limit = Time.now.change(:hour => 7)
      lower_limit = Time.now.change(:hour => 22)
      time_frame_flag = (Time.now>upper_limit)&&(Time.now.<lower_limit)
  end
end
