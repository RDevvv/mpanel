class AdPromocode < ActiveRecord::Base
  attr_accessible :ad_id, :cap, :is_used, :set_name, :usage, :promocode, :outlet_ids, :promocodes
  attr_accessor :promocodes
  belongs_to :ad
  has_many :ad_promocode_outlets,:dependent=>:destroy
  has_many :outlets,:through=>:ad_promocode_outlets
end
