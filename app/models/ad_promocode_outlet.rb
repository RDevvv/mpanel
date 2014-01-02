class AdPromocodeOutlet < ActiveRecord::Base
  attr_accessible :ad_id, :ad_promocode_id, :outlet_id, :deleted_at
  belongs_to :ad
  belongs_to :ad_promocode
  belongs_to :outlet
  has_paper_trail
  acts_as_paranoid
end
