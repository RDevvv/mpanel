class AdGroup < ActiveRecord::Base
  attr_accessible :name, :ad_id,:is_multiple, :deleted_at
  has_many :ad_promocodes, :dependent=>:destroy
  has_many :outlets, :through=>:ad_promocodes
  has_many :ad_promocode_outlets, :through=>:ad_promocodes
  belongs_to :ad
  validates_presence_of :name

  acts_as_paranoid
  
  def delete_outlet(outlet_id)
    self.ad_promocode_outlets.where(:outlet_id=>outlet_id).destroy_all
  end

  def add_more_outlets(outlet_ids)
    outlet_ids = Array(outlet_ids).reject {|x| x.blank?}
    
    if outlet_ids.include?("All")
      outlets = self.ad.account_brand.outlets - self.outlets
      outlet_ids = Array(outlets.collect(&:id))
    end  
 
    self.ad_promocodes.each do |promocode|
      promocode.outlet_ids = (promocode.outlet_ids + outlet_ids).flatten.compact.uniq
      promocode.save
    end
  end

end
