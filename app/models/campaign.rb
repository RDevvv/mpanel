class Campaign < ActiveRecord::Base
    belongs_to :ad_promocode_outlet
    has_many :campaign_copies

    attr_accessible :campaign_name, :target, :placement, :purpose, :campaign_url, :campaign_template, :campaign_type
    attr_accessible :ad_promocode_outlet_id, :expires_at, :keyword, :marketer, :medium
    attr_accessible :source, :use_count
end
