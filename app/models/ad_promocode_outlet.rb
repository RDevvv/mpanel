class AdPromocodeOutlet < ActiveRecord::Base
  attr_accessible :ad_id, :ad_promocode_id, :outlet_id
  belongs_to :ad
  belongs_to :ad_promocode
  belongs_to :outlet
  has_paper_trail

end
