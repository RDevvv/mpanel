class AdPromocode < ActiveRecord::Base
  attr_accessible :ad_id, :cap, :is_used, :set_name, :usage, :promocode, :outlet_ids, :promocodes, :is_active, :ad_group_id
  attr_accessor :promocodes
  belongs_to :ad
  belongs_to :ad_group
  has_many :ad_promocode_outlets,:dependent=>:destroy
  has_many :outlets,:through=>:ad_promocode_outlets
  validates :promocode, :format => { :with => /\A[a-zA-Z0-9]+\z/,:message => "Invalid Promocode" } 
  validates_presence_of :set_name
  before_destroy :can_delete
  def can_delete
    (self.usage.blank? || self.usage.to_i == 0) ? true : false
  end
end
