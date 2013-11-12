class Area < ActiveRecord::Base
  attr_accessible :area_alias, :area_name, :city_id, :pincode
  has_many :account, :dependent => :destroy
  has_many :outlet, :dependent => :destroy
  belongs_to :city
end
