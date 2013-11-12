class MultipleCodesSpecificOutlets < ActiveRecord::Base
  attr_accessible :outlet_ad_id, :is_deleted, :is_used, :promocode, :start_date, :start_date
  belongs_to :outlet_ad
end
