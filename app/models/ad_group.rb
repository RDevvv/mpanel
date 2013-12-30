class AdGroup < ActiveRecord::Base
  attr_accessible :is_active, :name, :ad_id,:is_multiple
  has_many :ad_promocodes, :dependent=>:destroy
  has_many :outlets, :through=>:ad_promocodes
  has_many :ad_promocode_outlets, :through=>:ad_promocodes
  

  belongs_to :ad
  validates_presence_of :name
  def toggle_active
    self.is_active? ?  self.deactivate : self.activate

  end

  def activate
    self.is_active = true
    self.ad_promocodes.update_all(:is_active=>true)
    self.save
  end

  def deactivate
    self.is_active = false
    self.ad_promocodes.update_all(:is_active=>false)
    self.save
  end

  def delete_outlet(outlet_id)
    self.ad_promocode_outlets.where(:outlet_id=>outlet_id).destroy_all
  end

  def add_more_outlets(outlet_ids)
    outlet_ids = Array(outlet_ids).reject {|x| x.blank?}
    self.ad_promocodes.each do |promocode|
      promocode.outlet_ids = (promocode.outlet_ids + outlet_ids).flatten.compact.uniq
      promocode.save
    end
  end
end
