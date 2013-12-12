class AdGroup < ActiveRecord::Base
  attr_accessible :is_active, :name, :ad_id
  has_many :ad_promocodes, :dependent=>:destroy
  has_many :outlets, :through=>:ad_promocodes
  

  belongs_to :ad
  validates_presence_of :name
end
