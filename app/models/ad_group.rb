class AdGroup < ActiveRecord::Base
  attr_accessible :is_active, :name, :ad_id
  has_many :ad_promocodes, :dependent=>:destroy
  belongs_to :ad
end
