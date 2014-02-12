class MissedCall < ActiveRecord::Base
    belongs_to :campaign
    attr_accessible :call_sid, :from, :is_valid, :to, :campaign_id

end
