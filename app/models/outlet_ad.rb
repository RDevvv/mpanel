class OutletAd < ActiveRecord::Base
  attr_accessible :ad_id, :is_deleted, :outlet_id
  has_many :multiple_codes_specific_outlets, :dependent => :destroy
  has_many :single_code_specific_outlets, :dependent => :destroy
  belongs_to :ad
  belongs_to :outlet
end
