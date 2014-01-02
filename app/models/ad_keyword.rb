class AdKeyword < ActiveRecord::Base
  attr_accessible :ad_id, :keyword_id, :deleted_at
  belongs_to :ad
  belongs_to :keyword

  acts_as_paranoid
end
