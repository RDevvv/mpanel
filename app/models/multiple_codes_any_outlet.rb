class MultipleCodesAnyOutlet < ActiveRecord::Base
  attr_accessible :ad_id, :end_date, :is_deleted, :is_used, :promocode, :start_date
  belongs_to :ad
end
