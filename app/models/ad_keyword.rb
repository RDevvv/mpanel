class AdKeyword < ActiveRecord::Base
  attr_accessible :ad_id, :keyword_id, :deleted_at
  belongs_to :ad
  belongs_to :keyword

  validates :ad_id, :uniqueness => {:scope => :keyword_id}

  acts_as_paranoid
end
