class AdPromocode < ActiveRecord::Base
  attr_accessible :ad_id, :cap, :is_used, :usage, :promocode, :outlet_ids, :promocodes, :is_active, :ad_group_id, :deleted_at,:set_name
  attr_accessor :promocodes
  belongs_to :ad
  belongs_to :ad_group
  has_many :ad_promocode_outlets,:dependent=>:destroy
  has_many :outlets,:through=>:ad_promocode_outlets
  validates :promocode, :format => { :with => /\A[a-zA-Z0-9]+\z/,:message => "Invalid Promocode" } 
  before_destroy :can_delete
  after_save :inactive_ad_promocode
  attr_accessor :set_name
  acts_as_paranoid
  after_create :add_ad
  
  def add_ad_group(ad,name)
    @ad_group = ad.ad_groups.create!(:name=>name)
  end

  def add_ad
    self.ad_id = self.ad_group.ad.id
    self.save
  end    
  
  def can_delete
    (self.usage.blank? || self.usage.to_i == 0) ? true : false
  end

  def inactive_ad_promocode
    if self.usage != self.cap
      self.is_active = false
    end
  end
  
end
