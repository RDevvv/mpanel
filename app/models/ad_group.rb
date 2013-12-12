class AdGroup < ActiveRecord::Base
  attr_accessible :is_active, :name, :ad_id
  has_many :ad_promocodes, :dependent=>:destroy
  has_many :outlets, :through=>:ad_promocodes
  

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
end
