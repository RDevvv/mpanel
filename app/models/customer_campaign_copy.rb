class CustomerCampaignCopy < ActiveRecord::Base
  belongs_to :customer
  belongs_to :campaign_copy
  attr_accessible :customer_ip
end
