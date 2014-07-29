class ReferralDownload < ActiveRecord::Base
  belongs_to :referrer, :class_name => 'Customer'
  belongs_to :referee, :class_name => 'Customer'

  attr_accessible :referrer_id, :referee_id, :is_calculated

  validates :referrer_id, :uniqueness => {:scope => :referee_id}
end
