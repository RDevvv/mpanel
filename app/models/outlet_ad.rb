class OutletAd < ActiveRecord::Base
  attr_accessible :ad_id, :is_deleted, :outlet_id
  belongs_to :ad
  belongs_to :outlet
end
