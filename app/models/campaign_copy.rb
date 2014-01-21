class CampaignCopy < ActiveRecord::Base
  belongs_to :campaign
  belongs_to :customer
  attr_accessible :copy_sent, :expires_at, :is_delivered, :is_opened, :is_sent, :use_count
end
